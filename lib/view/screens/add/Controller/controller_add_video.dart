import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/video_converter.dart';
import 'package:runwey_trend/model/video_list_model.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:runwey_trend/utils/app_constent.dart';
// import 'package:video_compress_plus/video_compress_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../../helper/prefs_helper.dart';
import '../../../../helper/socket_maneger.dart';
import '../../../../model/category_model.dart';
import '../../../../model/content_model.dart';
import '../../../../services/socket_constant.dart';

class AddVideoController extends GetxController {
  // var loading = false.obs;
 var rxRequestStatus=Status.loading.obs;
  setRxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  /// ,-------------- Check content creator permission ---------->
  var contentWritingPermission = ContentPermission.user.name.obs;
  updatePermission(String value) async {
    contentWritingPermission.value = value;
    update();
  }

  getPermission() async {
    setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(ApiConstant.getProfile);
    if (response.statusCode == 200) {
      debugPrint(
          "Content Creator Permission : ${response.body['data']['role']}");
      updatePermission(response.body['data']['role']);
      if(ContentPermission.creator.name==contentWritingPermission.value){
        await fastLoad();
      }
      setRxRequestStatus(Status.completed);
      update();
    } else {
      if(response.statusText==ApiClient.noInternetMessage){
        setRxRequestStatus(Status.internetError);
      }else{
        setRxRequestStatus(Status.error);
      }

      debugPrint("Check Error Status Text: ${response.statusText}");
      ApiChecker.checkApi(response);
    }


  }

  /// <------------------ Video Pick Camera and Gallery ------------------->


 picVideo(ImageSource source) async {
    try {
      final video = await ImagePicker()
          .pickVideo(source:source,maxDuration: const Duration(seconds: 15));

      if (video != null) {
        if (source == ImageSource.gallery) {
          checkVideoDuration(File(video.path));
        } else {
          Get.toNamed(AppRoute.uploadVideoDetails, arguments: File(video.path));
        }
      } else {
        debugPrint(AppConstants.error);
      }
    } on Exception catch (e) {

      debugPrint("========> Video pic error : $e");
      // TODO
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
      Get.toNamed(AppRoute.uploadVideoDetails, arguments: File(result.path));
    }
  }

  /// <----------------- Video thumbnail -------------->
  // Future<File> _getThumb(String videoPath) async{
  //  // final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
  //   return thumbnail;
  // }

  /// <---------------- Check Video duration ------>

  Future<int> _getVideoDuration(String path) async {
    final videoPlayerController = VideoPlayerController.file(File(path));
    await videoPlayerController.initialize();
    final duration = videoPlayerController.value.duration.inSeconds;
    await videoPlayerController.dispose();
    return duration;
  }

  /// <---------------- Check Size ------>
  Future<int> _getVideoSize(String path) async {
    final file = File(path);
    final length = await file.length();
    return length;
  }
  
  /// <------------------------- Get User Upload Content ----------------->
     RxList<ContentModel> allMyContentList=<ContentModel>[].obs;

 late ScrollController  scrollController;

 int page = 1;
 var isFirstLoadRunning = false.obs;
 var isLoadMoreRunning = false.obs;
 var totalPage=(-1);
 var currentPage=(-1);
 var searchLoading=false.obs;
 List<String> genderList = ["All", "Male", "Female"];
 var selectGender="All".obs;
 var selectCategory="".obs;
 var isSearch=false.obs;


 fastLoad()async {
   page=1;
   isSearch(false);
   selectCategory.value="";
   selectGender.value="All";
   setRxRequestStatus(Status.loading);
   Response response = await ApiClient.getData("${ApiConstant.myContent}?page=$page",);
   if (response.statusCode == 200) {
     currentPage=response.body['data']['attributes']['pagination']['currentPage'];
     totalPage=response.body['data']['attributes']['pagination']['totalPages'];
     allMyContentList.value = List<ContentModel>.from(response.body['data']['attributes']['videos'].map((x) => ContentModel.fromJson(x)));
     allMyContentList.refresh();
     await getCategory();
     // setRxRequestStatus(Status.completed);
   } else {
     if(ApiClient.noInternetMessage==response.statusText){
       setRxRequestStatus(Status.internetError);
     }else{
       setRxRequestStatus(Status.error);
     }
     ApiChecker.checkApi(response);
   }
 }

 loadMore() async {
   print("load more");
   if (rxRequestStatus.value != Status.loading &&
       isLoadMoreRunning.value == false&&totalPage != currentPage) {
     isLoadMoreRunning(true);
     page += 1;
     Response response = await ApiClient.getData("${ApiConstant.myContent}?occassionCategory=${selectCategory.value}&page=$page",);
     currentPage=response.body['data']['attributes']['pagination']['currentPage'];
     totalPage=response.body['data']['attributes']['pagination']['totalPages'];
     if (response.statusCode == 200) {
       var demoList = List<ContentModel>.from(response.body['data']['attributes']['videos'].map((x) => ContentModel.fromJson(x)));
       allMyContentList.addAll(demoList);
       allMyContentList.refresh();
     } else {
       ApiChecker.checkApi(response);
     }
     isLoadMoreRunning(false);
   }}

 searchLoad()async {
   page=1;
   searchLoading(true);
   isSearch(true);
   Response response = await ApiClient.getData("${ApiConstant.myContent}?occassionCategory=${selectCategory.value}&page=$page",);
   if (response.statusCode == 200) {
     currentPage=response.body['data']['attributes']['pagination']['currentPage'];
     totalPage=response.body['data']['attributes']['pagination']['totalPages'];
     allMyContentList.value = List<ContentModel>.from(response.body['data']['attributes']['videos'].map((x) => ContentModel.fromJson(x)));
     allMyContentList.refresh();
     searchLoading(false);
   } else {
     searchLoading(false);
     ApiChecker.checkApi(response);
   }
 }

 ///<--------------------- Get Category ------>


 RxList<CategoryModel> categoryList=<CategoryModel>[].obs;

 getCategory()async{
   var response= await ApiClient.getData(ApiConstant.getCategory);
   if(response.statusCode==200){
     categoryList.value=List<CategoryModel>.from(response.body['data']['attributes'].map((x) => CategoryModel.fromJson(x)));
     setRxRequestStatus(Status.completed);
   }else{
     ApiChecker.checkApi(response);
   }}


// like vido
  Future<bool> onLikeButtonTapped(bool isLiked,String videoId) async{

    var userId = await PrefsHelper.getString(AppConstants.userId);
    var data = {"userId": userId, "videoId": videoId};
    debugPrint("========== Like body $data");
    var response = await SocketApi.emitWithAck(SocketConstants.likeEvent, data);
    var success =isLiked;
    if(response['status']){
      for (int i = 0; i < allMyContentList.length; i++) {
        if (allMyContentList[i].id == videoId) {
          if (allMyContentList[i].isLiked==true) {
            allMyContentList[i].likes=allMyContentList[i].likes- 1;
            allMyContentList[i].isLiked = false;
            allMyContentList.refresh();
            debugPrint("========== view like ${allMyContentList[i].likes}");
            success=false;
            //  return contentList[i].isLiked!;
          } else {
            allMyContentList[i].likes=allMyContentList[i].likes +1;
            allMyContentList[i].isLiked = true;
            allMyContentList.refresh();
            debugPrint("========== view like ${allMyContentList[i].likes}");
            success=true;
          }

        }
      }
    }

    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    return success;

    // return !isLiked;
  }



}
