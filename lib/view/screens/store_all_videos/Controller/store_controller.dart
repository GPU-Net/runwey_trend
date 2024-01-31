
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/prefs_helper.dart';
import '../../../../helper/socket_maneger.dart';
import '../../../../model/content_model.dart';
import '../../../../services/api_check.dart';
import '../../../../services/api_client.dart';
import '../../../../services/api_constant.dart';
import '../../../../services/socket_constant.dart';
import '../../../../utils/app_constent.dart';

class StoreAllVideoController extends GetxController{
  late ScrollController  scrollController;
  RxList<ContentModel> allStoreContentList = <ContentModel>[].obs;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var totalPage=(-1);
  var currentPage=(-1);
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  refreshLoad()async {
    page=1;
    Response response =
    await ApiClient.getData("${ApiConstant.newestContent}?page=$page",);
    if (response.statusCode == 200) {
      currentPage=response.body['data']['attributes']['pagination']['currentPage'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      allStoreContentList.value = List<ContentModel>.from(response.body['data']['attributes']['videos'].map((x) => ContentModel.fromJson(x)));
      allStoreContentList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  fastLoad(String userId)async {
    page=1;
    setRxRequestStatus(Status.loading);
    Response response =
    await ApiClient.getData("${ApiConstant.userByContent+userId}?page=$page",);
    if (response.statusCode == 200) {
      currentPage=response.body['data']['attributes']['pagination']['currentPage'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      allStoreContentList.value = List<ContentModel>.from(response.body['data']['attributes']['videos'].map((x) => ContentModel.fromJson(x)));
      allStoreContentList.refresh();

       setRxRequestStatus(Status.completed);
    } else {
      if(ApiClient.noInternetMessage==response.statusText){
        setRxRequestStatus(Status.internetError);
      }else{
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  loadMore(String userId) async {
    print("load more");
    if (rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false&&totalPage != currentPage) {
      isLoadMoreRunning(true);
      page += 1;
      Response response =
      await ApiClient.getData("${ApiConstant.userByContent+userId}?page=$page",);
      currentPage=response.body['data']['attributes']['pagination']['currentPage'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      if (response.statusCode == 200) {
        var demoList = List<ContentModel>.from(response.body['data']['attributes']['videos'].map((x) => ContentModel.fromJson(x)));
        allStoreContentList.addAll(demoList);
        allStoreContentList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }}



  Future<bool> onLikeButtonTapped(bool isLiked,String videoId) async{
    var userId = await PrefsHelper.getString(AppConstants.userId);
    var data = {"userId": userId, "videoId": videoId};
    debugPrint("========== Like body $data");
    var response = await SocketApi.emitWithAck(SocketConstants.likeEvent, data);
    var success =isLiked;
    if(response['status']){
      for (int i = 0; i < allStoreContentList.length; i++) {
        if (allStoreContentList[i].id == videoId) {
          if (allStoreContentList[i].isLiked==true) {
            allStoreContentList[i].likes=allStoreContentList[i].likes- 1;
            allStoreContentList[i].isLiked = false;
            allStoreContentList.refresh();
            debugPrint("========== view like ${allStoreContentList[i].likes}");
            success=false;
            //  return contentList[i].isLiked!;
          } else {
            allStoreContentList[i].likes=allStoreContentList[i].likes +1;
            allStoreContentList[i].isLiked = true;
            allStoreContentList.refresh();
            debugPrint("========== view like ${allStoreContentList[i].likes}");
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



  handleView(String videoId) async {
    debugPrint("========== View Video Id $videoId");
    var data = {"videoId": videoId};
    var response = await SocketApi.emitWithAck(SocketConstants.viewEvent, data);
    if (response['status']) {
      for (int i = 0; i < allStoreContentList.length; i++) {
        if (allStoreContentList[i].id == videoId) {
          allStoreContentList[i].popularity =allStoreContentList[i].popularity + 1;
          allStoreContentList.refresh();
          debugPrint("========== view count ${allStoreContentList[i].popularity}");
          break;

        }
      }
    }
  }

}