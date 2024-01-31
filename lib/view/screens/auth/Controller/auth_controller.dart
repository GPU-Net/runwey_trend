import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/Bindings/navbar_bindings.dart';
import 'package:runwey_trend/helper/prefs_helper.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constent.dart';
import '../../../../utils/device_utils.dart';
import '../../botttom_nav_bar/bottom_nav_bar.dart';

class AuthController extends GetxController {
  /// <---------------- Sign Up Section ----------------->

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
   TextEditingController passwordCtrl = TextEditingController();
  TextEditingController conPasswordCtrl = TextEditingController();

  List<String> genderList = ["Male", "Female"];
  RxInt selectedGender = 0.obs;
  RxBool isClicked = false.obs;
  var phoneCode = "+353".obs;

  void changeGender(int index) {
    selectedGender.value = index;
    update();
  }

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime minimumAllowedDate =
        currentDate.subtract(Duration(days: 365 * 18));

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
        }
    );

    if (picked != null) {
      selectedDate = picked;
      dobCtrl.text =
          "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
    }

    // if (picked != null && picked != selectedDate && picked.isBefore(minimumAllowedDate)) {
    //   // The selected date is valid (not null, not equal to the current date, and at least 18 years ago)
    //     selectedDate = picked;
    //
    // } else {
    //
    // //  Fluttertoast.showToast(msg:"Invalid date selection.You must be at least 18 years old.");
    //
    //   print('Invalid date selection. You must be at least 18 years old.');
    // }
  }

  var signUpLoading = false.obs;
  var token="";

  handleSignUp() async {
    signUpLoading(true);
    Map<String, dynamic> body = {
      "fullName": nameCtrl.text.trim(),
      "dateOfBirth": dobCtrl.text.trim(),
      "gender": genderList[selectedGender.value],
      "email": emailCtrl.text.trim(),
      "phoneNumber": "${phoneCtrl.text.trim()}",
      "countryCode":"${phoneCode.value}",
      "password": passwordCtrl.text
    };
    var headers = {'Content-Type': 'application/json'};
    Response response = await ApiClient.postData(
        ApiConstant.signUpEndPoint, jsonEncode(body),
        headers: headers);

    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.body['message']);
      token = response.body['token'];
      Get.toNamed(AppRoute.otpScreen, parameters: {
        "email": emailCtrl.text.trim(),
        "screenType": OptScreenType.signupotp.name,
      });

      nameCtrl.clear();
      dobCtrl.clear();
      selectedGender.value = 0;
      emailCtrl.clear();
      phoneCtrl.clear();
      phoneCode.value = "+93";
      passwordCtrl.clear();
      conPasswordCtrl.clear();
    } else {
      ApiChecker.checkApi(response);
    }
    signUpLoading(false);
  }

  /// <--------------------------------- verify otp ------------------------------------>

  TextEditingController otpCtrl = TextEditingController();
  var verifyLoading = false.obs;

  handleOtpVery(
      {required String email,
      required String otp,
      required String type}) async {
    var body = {'oneTimeCode': otp, 'email': email};
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    verifyLoading(true);
    Response response = await ApiClient.postData(
        ApiConstant.otpVerifyEndPoint, body,
        headers: headers);
    if (response.statusCode == 200) {
      otpCtrl.clear();
      if (type == OptScreenType.signupotp.name) {
        await  PrefsHelper.setString(AppConstants.bearerToken, token);
        await  PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['_id']);
        await  PrefsHelper.setString(AppConstants.gender, response.body['data']['attributes']['gender']);
        DeviceUtils.screenUtils();
        Get.offAll(CustomNavBar(currentIndex:0),binding:NavBarBinding());
      } else {
        Get.offAndToNamed(AppRoute.resetPasswordScreen,arguments:email);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    verifyLoading(false);
  }

  
  /// <-------------------------------- Sign in screen --------------------------->
  TextEditingController signInPassCtrl = TextEditingController();
  TextEditingController signInEmailCtrl = TextEditingController();
var signInLoading =false.obs;
  
  handleSignIn()async{
    signInLoading(true);
    var headers = {
      //'Content-Type': 'application/x-www-form-urlencoded'
      'Content-Type': 'application/json'
    };
    Map<String,dynamic> body={
      'email': signInEmailCtrl.text.trim(),
      'password': signInPassCtrl.text.trim()
    };
    Response response= await ApiClient.postData(ApiConstant.signInEndPoint,json.encode(body),headers: headers);
    if(response.statusCode==200){
     if(response.body['data']['attributes']['role']!="admin"){
       await  PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
       await  PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['_id']);
       await  PrefsHelper.setString(AppConstants.gender, response.body['data']['attributes']['gender']);
       Get.offAll(CustomNavBar(currentIndex:0),binding:NavBarBinding());
       signInEmailCtrl.clear();
       signInPassCtrl.clear();
     }
    }else{
    //  ApiChecker.checkApi(response);
      Fluttertoast.showToast(msg:response.statusText??"");
    }
    signInLoading(false);
  }


  signOut()async{
    await PrefsHelper.remove(AppConstants.bearerToken);
    Get.offAllNamed(AppRoute.signInScreen);
  }
  


  /// <------------- Forgot Password ---------->

  TextEditingController forgetEmailTextCtrl=TextEditingController();
  TextEditingController forgetConfirmPassTextCtrl=TextEditingController();
  TextEditingController forgetNewPassTextCtrl=TextEditingController();
    var forgotLoading=false.obs;

  handleForget()async{
    forgotLoading(true);
    var body = {
      "email":forgetEmailTextCtrl.text.trim(),
    };
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var response= await ApiClient.postData(ApiConstant.forgetEndPoint, json.encode(body),headers: headers);
    if(response.statusCode==201){
      Get.toNamed(AppRoute.otpScreen, parameters: {
        "email": forgetEmailTextCtrl.text.trim(),
        "screenType": OptScreenType.forgotOtp.name,
      });
      forgetEmailTextCtrl.clear();
    }else{
      ApiChecker.checkApi(response);
    }
    forgotLoading(false);
  }
  
  handleResendOtp(String email)async{
    var body = {
      "email":email.trim(),
    };
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var response= await ApiClient.postData(ApiConstant.forgetEndPoint, json.encode(body),headers: headers);
    if(response.statusCode==201){
      Fluttertoast.showToast(msg:response.body['message']);
      debugPrint(AppConstants.successful);
    }
    
  }

  /// <-------------- Reset Password -------->
 TextEditingController resetPassCtrl=TextEditingController();
 TextEditingController resetConfirmPassCtrl=TextEditingController();
var resetPasswordLoading=false.obs;
 handleResetPassword(String email,String password)async{
    resetPasswordLoading(true);
   Map<String,dynamic>body={
   'email': email,
   'password':password
   };
   var header= {"Content-Type": "application/x-www-form-urlencoded"};
   Response response = await ApiClient.postData(ApiConstant.resetPassword, body,headers: header);
   if(response.statusCode==200){
     Get.offNamed(AppRoute.signInScreen);
     resetConfirmPassCtrl.clear();
     resetPassCtrl.clear();
     Fluttertoast.showToast(msg:AppConstants.successful);
     resetPasswordLoading(false);
   }else{
     ApiChecker.checkApi(response);
   }
    resetPasswordLoading(false);

 }






}
