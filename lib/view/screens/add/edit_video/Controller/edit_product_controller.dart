import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:runwey_trend/model/content_model.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../helper/video_converter.dart';
import '../../../../../model/category_model.dart';
import '../../../../../services/api_check.dart';
import '../../../../../services/api_client.dart';
import '../../../../../services/api_constant.dart';
import '../../../../../utils/app_constent.dart';
import '../../upload_video_details/Controller/video_widget_controller.dart';
import '../../upload_video_details/inner_widgets/success_dialog.dart';

class EditVideoController extends GetxController {
  static var client = http.Client();

  final _videoWidgetController = Get.put(VideoWidgetController());
  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  var videoFilePath ="".obs;
  var videoUrlPath="".obs;
  List<String> sizeList = [
    's',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL',
  ];

  picVideo(ImageSource source) async {
    final video = await ImagePicker().pickVideo(
      source: source,
      maxDuration: const Duration(seconds: 15),
    );

    if (video != null) {
      if (source == ImageSource.gallery) {
        checkVideoDuration(File(video.path));
      } else {
        videoFilePath.value = video.path;
        _videoWidgetController.chewieController.dispose();
        _videoWidgetController.videoPlayerController.dispose();
        _videoWidgetController.initializePlayer(videoFilePath.value);
        // debugPrint("video file path : ${videoFilePath.value}");
        // Get.toNamed(AppRoute.uploadVideoDetails, arguments: File(video.path));
      }
      debugPrint("video file path : ${videoFilePath.value}");
    } else {
      debugPrint(AppConstants.error);
    }
  }





  checkVideoDuration(File result) async {
    // Check video duration and size
    final videoDuration = await _getVideoDuration(result.path);
    //  final videoSize = await _getVideoSize(result.path);

    print('Video Duration: $videoDuration seconds');
    // print('Video Size: $videoSize bytes');
    if (videoDuration > 16) {
      // Show toast if duration is greater than 10 seconds or size is greater than 10 MB
      Fluttertoast.showToast(
        msg: 'Upload max of 15 sec video.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      // Process the video further if needed
      print('Video is within the limits');
      videoFilePath.value = result.path;
      _videoWidgetController.chewieController.dispose();
      _videoWidgetController.videoPlayerController.dispose();
      _videoWidgetController.initializePlayer(videoFilePath.value);
      // Get.toNamed(AppRoute.uploadVideoDetails, arguments: File(result.path));
    }
  }

  /// <---------------- Check Video duration ------>
  Future<int> _getVideoDuration(String path) async {
    final videoPlayerController = VideoPlayerController.file(File(path));
    await videoPlayerController.initialize();
    final duration = videoPlayerController.value.duration.inSeconds;
    await videoPlayerController.dispose();
    return duration;
  }

  ///<--------------------- Get Category ------>

  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  getCategory(ContentModel contentModel) async {
    var response = await ApiClient.getData(ApiConstant.getCategory);
    if (response.statusCode == 200) {
      categoryList.value = List<CategoryModel>.from(response.body['data']
              ['attributes']
          .map((x) => CategoryModel.fromJson(x)));
      updateData(contentModel);
      setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///<--------------------- Upload Video ----------------->
  TextEditingController titleTextCtrl = TextEditingController();
  TextEditingController countryNameTextCtrl = TextEditingController();
  TextEditingController fabricTextCtrl = TextEditingController();
  TextEditingController materialTextCtrl = TextEditingController();
  TextEditingController careTextCtrl = TextEditingController();
  TextEditingController instagramLinkTextCtrl = TextEditingController();
  TextEditingController tiktokLinkTextCtrl = TextEditingController();
  TextEditingController descriptionTextCtrl = TextEditingController();

  List genderList = ["Male", "Female"];
  var selectSize = "s".obs;
  var selectCategoryIndex = 0.obs;
  var selectGenderIndex = 0.obs;

  var uploadLoading = false.obs;

  uploadVideo(String videoPath, String id) async {
    uploadLoading(true);
    String? thumbnail;
    var convertPath;
    if(videoPath.isNotEmpty){
    thumbnail  = await _getThumb(videoPath);
    convertPath= await checkVideoExtensionAndConvert(videoPath);
    }






    var response;
      if(videoPath.isNotEmpty){
        if(convertPath !=null){
          Map<String, String> body = {
            'title': titleTextCtrl.text,
            'size': selectSize.value,
            'countryName': countryNameTextCtrl.text,
            'fabric': fabricTextCtrl.text,
            'material': materialTextCtrl.text,
            'care': careTextCtrl.text,
            'category': categoryList[selectCategoryIndex.value].name ?? "",
            // 'gender': genderList[selectGenderIndex.value],
            'description': descriptionTextCtrl.text,
            'tiktok': tiktokLinkTextCtrl.text,
            "instragram": instagramLinkTextCtrl.text,
          };
          List<MultipartBody> multipartBody = [
            MultipartBody("videoData", File(convertPath)),
            MultipartBody("thumbnail", File(thumbnail??"")),
          ];
           response = await ApiClient.putMultipartData(
              ApiConstant.editContent+id, body,
              multipartBody:videoPath.isNotEmpty?multipartBody:[]);
        }else{
          uploadLoading(false);
          Fluttertoast.showToast(msg:"Unsupported video format!");
        }
      }else{
        Map<String, String> body = {
          'title': titleTextCtrl.text,
          'size': selectSize.value,
          'countryName': countryNameTextCtrl.text,
          'fabric': fabricTextCtrl.text,
          'material': materialTextCtrl.text,
          'care': careTextCtrl.text,
          'occassionCategory': categoryList[selectCategoryIndex.value].name ?? "",
          // 'gender': genderList[selectGenderIndex.value],
          'description': descriptionTextCtrl.text.trim(),
          'tiktok': tiktokLinkTextCtrl.text.trim(),
          "instragram": instagramLinkTextCtrl.text.trim(),
        };
        response = await ApiClient.putMultipartData(
            ApiConstant.editContent+id, body,multipartBody: []
            );
      }

      if (response.statusCode == 200) {
        uploadLoading(false);
        showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) =>  const CustomSuccessAlertBox(
              title: "Product Video Updated Successfully",
              subTitle: "",
            ));
        tiktokLinkTextCtrl.clear();
        titleTextCtrl.clear();
        careTextCtrl.clear();
        countryNameTextCtrl.clear();
        fabricTextCtrl.clear();
        materialTextCtrl.clear();
        instagramLinkTextCtrl.clear();
        descriptionTextCtrl.clear();
        selectGenderIndex.value = 0;
        selectCategoryIndex.value = 0;
        selectSize.value = "s";
      } else {
        uploadLoading(false);
        ApiChecker.checkApi(response);
        // }
        uploadLoading(false);
        update();
      }



  }

  Future<String?> _getThumb(String videoPath) async {
    // final thumbnail = await VideoCompress.getFileThumbnail(videoPath,quality: 50, // default(100)
    //   position: -1,);
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );
    debugPrint("Thumb Path : $thumbnail");
    return thumbnail;
  }
  Future<String?> checkVideoExtensionAndConvert(String filePath)async{
    if(!filePath.toLowerCase().endsWith('.mp4')){
      try {
        var outputPath=   await VideoConverter.convertVideoToMp4(filePath);
        debugPrint("=====>Conversion successful: $outputPath");
        return outputPath;
      } catch (error) {
        print("Conversion failed for ${filePath}: $error");
        // Optionally notify user of conversion failure
        return null;
      }
    }else{
      return filePath;
    }
  }


  updateData(ContentModel contentModel) async {
    tiktokLinkTextCtrl.text = contentModel.tiktok ?? "";
    titleTextCtrl.text = contentModel.title ?? "";
    careTextCtrl.text = contentModel.care ?? "";
    countryNameTextCtrl.text = contentModel.countryName ?? "";
    fabricTextCtrl.text = contentModel.fabric ?? "";
    materialTextCtrl.text = contentModel.material ?? "";
    instagramLinkTextCtrl.text = contentModel.instragram ?? "";
    descriptionTextCtrl.text = contentModel.description ?? "";
    selectSize.value = contentModel.size ?? "";
    videoFilePath.value="";
    videoUrlPath.value=contentModel.videoPath??"";
    debugPrint("======> size : ${contentModel.size}");
    debugPrint("======> category : ${contentModel.occassionCategory}");

    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].name == contentModel.occassionCategory) {
        selectCategoryIndex.value = i;
      }
    }

    // for (int j = 0; j < genderList.length; j++) {
    //   if (categoryList[j].name == contentModel.occassionCategory) {
    //     selectGenderIndex.value = j;
    //   }
    // }
  }




  @override
  void dispose() {
    tiktokLinkTextCtrl.dispose();
    titleTextCtrl.dispose();
    careTextCtrl.dispose();
    countryNameTextCtrl.dispose();
    fabricTextCtrl.dispose();
    materialTextCtrl.dispose();
    instagramLinkTextCtrl.dispose();
    descriptionTextCtrl.dispose();
    selectGenderIndex.value = 0;
    selectCategoryIndex.value = 0;
    selectSize.value = "";
    super.dispose();
  }
}
