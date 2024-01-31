import 'dart:io';
import 'dart:typed_data';import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:runwey_trend/helper/convert_image.dart';

import 'package:runwey_trend/model/profile_model.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:runwey_trend/utils/app_colors.dart';

import '../../../../core/route/app_route.dart';
import '../../../../helper/prefs_helper.dart';
import '../../../../helper/socket_maneger.dart';
import '../../../../services/socket_constant.dart';
import '../../../../utils/app_constent.dart';

class ProfileController extends GetxController{
    @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  final rxRequestStatus=Status.loading.obs;
  void setRxRequestStatus (Status _value)=>rxRequestStatus.value=_value;
  final Rx<ProfileModel> profileData=ProfileModel().obs;
  getProfileData()async{
   setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(ApiConstant.getProfile);
    if(response.statusCode==200){
      
      profileData.value=ProfileModel.fromJson(response.body['data']);
    await  PrefsHelper.setString(AppConstants.subscriptionType, profileData.value.subcriptionType);
    await  PrefsHelper.setString(AppConstants.gender,profileData.value.gender);
      profileData.refresh();
      setRxRequestStatus(Status.completed);
    }else{
      if(response.statusText==ApiClient.noInternetMessage){
        setRxRequestStatus(Status.internetError);
      }else{
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }

  }


///  <------------------  Profile Edit ---------------->

    TextEditingController nameCtrl = TextEditingController();
    TextEditingController dobCtrl = TextEditingController();
    TextEditingController phoneCtrl = TextEditingController();
    TextEditingController emailCtrl = TextEditingController();

    List<String> genderList = ["Male", "Female"];
    RxInt selectedGender = 0.obs;
    RxBool isClicked = false.obs;
    var phoneCode = "+93".obs;
    var imagePath="".obs;
    var loading=false.obs;

    void changeGender(int index) {
      selectedGender.value = index;
      update();
    }

    DateTime selectedDate = DateTime.now();
    Future<void> selectDate(BuildContext context) async {
      final DateTime currentDate = DateTime.now();
      final DateTime minimumAllowedDate =
      currentDate.subtract(const Duration(days: 365 * 18));

      DateTime? picked = await showDatePicker(
        context: context,

        initialDate: minimumAllowedDate,
        firstDate: DateTime(1900),
        lastDate: currentDate,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AppColors.purple, // Your primary color// Your accent color
                colorScheme: const ColorScheme.light(primary: AppColors.purple),
                buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              // Change the background color here
              ),
              child: child!,
            );
          });
      if (picked != null) {
        selectedDate = picked;
        debugPrint("sssssss ${picked}");
        dobCtrl.text =
        "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
      }
    }



    Future<void> pickImage() async {
      final ImagePicker _picker = ImagePicker();
      try {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

        // Check if the image is not null
        if (image != null) {

          var file= File(image.path);
          imagePath.value=file.path;

          // Compress the image
          // You can use other packages like image or flutter_image_compress for compression
          // Handle the compressed image accordingly
        }
      } catch (e) {
        print("Error picking image: $e");
      }
    }



    updateData(){
      nameCtrl.text=profileData.value.fullName??"";
      dobCtrl.text="${profileData.value.dateOfBirth!.year}/${profileData.value.dateOfBirth!.month}/${profileData.value.dateOfBirth!.day}";
      // if(profileData.value.gender=="Male"){
      //   selectedGender.value=0;
      // }else{
      //   selectedGender.value=1;
      // }
      phoneCode.value=profileData.value.countryCode??"+93";
      phoneCtrl.text=profileData.value.phoneNumber??"";
      emailCtrl.text=profileData.value.email??"";
    }


    editProfile()async{
      loading(true);
      var body={
        'fullName': nameCtrl.text,
        'countryCode':phoneCode.value,
        'phoneNumber': phoneCtrl.text,
        'dateOfBirth':dobCtrl.text.trim(),
      //  "gender": genderList[selectedGender.value],
      };
      var isHeic=false.obs;
      var pathC;
      if(imagePath.value.endsWith(".heic")||imagePath.value.endsWith(".heif")) {
        isHeic.value=true;
      }
        if(isHeic.value){
          var convertedPath= await ImageConvertHelper.compressAndTryCatch(imagePath.value);
          final outputFilePath = path.setExtension(imagePath.value,'.png');
          pathC = await saveUint8ListToFile(convertedPath!,outputFilePath);
        }
          debugPrint("======> path : $pathC");
        List<MultipartBody> multipartBody=[
          MultipartBody('image', File(isHeic.value?pathC.path:imagePath.value))
        ];
        var response = await ApiClient.putMultipartData(ApiConstant.updateProfile, body,multipartBody:imagePath.isEmpty?[]:multipartBody);
        if(response.statusCode==200){
          await getProfileData();
          Fluttertoast.showToast(msg:"Profile updated successfully");
          Get.back();
        }else{
          ApiChecker.checkApi(response);
        }
        loading(false);

    }

    Future<File> saveUint8ListToFile(Uint8List data, String filePath) async {
      File file = File(filePath);

      // Write the Uint8List data to the file
      await file.writeAsBytes(data);
      return file;
    }


crateChatRoom()async{
  var userId = await PrefsHelper.getString(AppConstants.userId);
  var response=await SocketApi.emitWithAck(SocketConstants.createRoomEvent,{
    "userId":userId
  });
  debugPrint("======> response : $response");
  if(response['status']=="Success"){
    Get.toNamed(AppRoute.chatScreen,arguments:response['chatId']);
  }
}


}