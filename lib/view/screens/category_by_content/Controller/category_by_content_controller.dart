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

class CategoryByContentController extends GetxController{

  late ScrollController  scrollController;
  RxList<ContentModel> contentList = <ContentModel>[].obs;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var totalPage=(-1);
  var currentPage=(-1);
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  var searchText="".obs;
  var searchLoading=false.obs;
  List<String> genderList = ["All", "Male", "Female"];
  var selectGender="All".obs;



  refreshLoad()async{
    page=1;
    Response response =
    await ApiClient.getData("${ApiConstant.newestContent}?page=$page",);
    if (response.statusCode == 200) {
      currentPage=response.body['data']['attributes']['pagination']['currentPage'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      contentList.value = List<ContentModel>.from(response.body['data']['attributes']['newestVideos'].map((x) => ContentModel.fromJson(x)));
      contentList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  fastLoad(String categoryName,bool isSearch)async {
    page=1;
    if(!isSearch){
      setRxRequestStatus(Status.loading);
    }else{
    searchLoading(true);
    }

    Response response = searchText.value.isEmpty?
    await ApiClient.getData("${ApiConstant.searchContent}?occassionCategory=$categoryName&gender=${selectGender.value}&page=$page",):await ApiClient.getData("${ApiConstant.searchContent}?occassionCategory=$categoryName&gender=${selectGender.value}&title=${searchText.value}&page=$page",);

    if (response.statusCode == 200) {
      currentPage=response.body['pagination']['currentPage'];
      totalPage=response.body['pagination']['totalPage'];
      contentList.value = List<ContentModel>.from(response.body['data'].map((x) => ContentModel.fromJson(x)));
      contentList.refresh();
       setRxRequestStatus(Status.completed);
      searchLoading(false);
    } else {
      if(!isSearch){
        if(ApiClient.noInternetMessage==response.statusText){
          setRxRequestStatus(Status.internetError);
        }else{
          setRxRequestStatus(Status.error);
        }
      }else{
        searchLoading(false);
      }
      ApiChecker.checkApi(response);
    }
  }

  loadMore(String categoryName) async {
    print("load more");
    if (rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false&&totalPage != currentPage) {
      isLoadMoreRunning(true);
      page += 1;
      Response response = searchText.value.isEmpty?
      await ApiClient.getData("${ApiConstant.searchContent}?occassionCategory=$categoryName&gender=${selectGender.value}&page=$page",):await ApiClient.getData("${ApiConstant.searchContent}?occassionCategory=$categoryName&gender=${selectGender.value}&title=${searchText.value}&page=$page",);

      currentPage=response.body['pagination']['currentPage'];
      totalPage=response.body['pagination']['totalPage'];
      if (response.statusCode == 200) {
        var demoList = List<ContentModel>.from(response.body['data'].map((x) => ContentModel.fromJson(x)));
        contentList.addAll(demoList);
        contentList.refresh();
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
      for (int i = 0; i < contentList.length; i++) {
        if (contentList[i].id == videoId) {
          if (contentList[i].isLiked==true) {
            contentList[i].likes=contentList[i].likes- 1;
            contentList[i].isLiked = false;
            contentList.refresh();
            debugPrint("========== view like ${contentList[i].likes}");
            success=false;
            //  return contentList[i].isLiked!;
          } else {
            contentList[i].likes=contentList[i].likes +1;
            contentList[i].isLiked = true;
            contentList.refresh();
            debugPrint("========== view like ${contentList[i].likes}");
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
      for (int i = 0; i < contentList.length; i++) {
        if (contentList[i].id == videoId) {
          contentList[i].popularity =contentList[i].popularity + 1;
          contentList.refresh();
          debugPrint("========== view count ${contentList[i].popularity}");
          break;

        }
      }
    }
  }

}