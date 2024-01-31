import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/prefs_helper.dart';
import '../../../../helper/socket_maneger.dart';
import '../../../../model/category_model.dart';
import '../../../../model/content_model.dart';
import '../../../../services/api_check.dart';
import '../../../../services/api_client.dart';
import '../../../../services/api_constant.dart';
import '../../../../services/socket_constant.dart';
import '../../../../utils/app_constent.dart';

class NewestController extends GetxController{
  late ScrollController  scrollController;
  RxList<ContentModel> newestContentList = <ContentModel>[].obs;
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
  var selectCategory="".obs;

  refreshLoad()async {
    page=1;
    Response response =searchText.value.isEmpty?
    await ApiClient.getData("${ApiConstant.newestContent}?occassionCategory=${selectCategory.value}&gender=${selectGender.value}&page=$page",):  await ApiClient.getData("${ApiConstant.newestContent}?page=$page",);
    if (response.statusCode == 200) {
      currentPage=response.body['data']['attributes']['pagination']['currentPage'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      newestContentList.value = List<ContentModel>.from(response.body['data']['attributes']['newestVideos'].map((x) => ContentModel.fromJson(x)));
      newestContentList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  fastLoad()async {
    page=1;
      setRxRequestStatus(Status.loading);
    Response response = await ApiClient.getData("${ApiConstant.newestContent}?occassionCategory=${selectCategory.value}&gender=${selectGender.value}&page=$page",);
    if (response.statusCode == 200) {
      currentPage=response.body['data']['attributes']['pagination']['currentPage'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      newestContentList.value = List<ContentModel>.from(response.body['data']['attributes']['newestVideos'].map((x) => ContentModel.fromJson(x)));
      newestContentList.refresh();
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
      Response response =
      searchText.value.isEmpty?
      await ApiClient.getData("${ApiConstant.newestContent}?occassionCategory=${selectCategory.value}&gender=${selectGender.value}&page=$page",):   await ApiClient.getData("${ApiConstant.newestContent}?occassionCategory=${selectCategory.value}&gender=${selectGender.value}&title=${searchText.value}&page=$page",);
      currentPage=response.body['data']['attributes']['pagination']['currentPage'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      if (response.statusCode == 200) {
        var demoList = List<ContentModel>.from(response.body['data']['attributes']['newestVideos'].map((x) => ContentModel.fromJson(x)));
        newestContentList.addAll(demoList);
        newestContentList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
     isLoadMoreRunning(false);
    }}

  searchLoad()async {
    page=1;
    searchLoading(true);
    Response response =
    searchText.value.isEmpty?
    await ApiClient.getData("${ApiConstant.newestContent}?occassionCategory=${selectCategory.value}&gender=${selectGender.value}&page=$page",):   await ApiClient.getData("${ApiConstant.newestContent}?occassionCategory=${selectCategory.value}&gender=${selectGender.value}&title=${searchText.value}&page=$page",);
    if (response.statusCode == 200) {
      currentPage=response.body['data']['attributes']['pagination']['currentPage'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      newestContentList.value = List<ContentModel>.from(response.body['data']['attributes']['newestVideos'].map((x) => ContentModel.fromJson(x)));
      newestContentList.refresh();
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





  Future<bool> onLikeButtonTapped(bool isLiked,String videoId) async{
    var userId = await PrefsHelper.getString(AppConstants.userId);
    var data = {"userId": userId, "videoId": videoId};
    debugPrint("========== Like body $data");
    var response = await SocketApi.emitWithAck(SocketConstants.likeEvent, data);
    var success =isLiked;
    if(response['status']){
      for (int i = 0; i < newestContentList.length; i++) {
        if (newestContentList[i].id == videoId) {
          if (newestContentList[i].isLiked==true) {
            newestContentList[i].likes=newestContentList[i].likes- 1;
            newestContentList[i].isLiked = false;
            newestContentList.refresh();
            debugPrint("========== view like ${newestContentList[i].likes}");
            success=false;
            //  return contentList[i].isLiked!;
          } else {
            newestContentList[i].likes=newestContentList[i].likes +1;
            newestContentList[i].isLiked = true;
            newestContentList.refresh();
            debugPrint("========== view like ${newestContentList[i].likes}");
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
      for (int i = 0; i < newestContentList.length; i++) {
        if (newestContentList[i].id == videoId) {
          newestContentList[i].popularity =newestContentList[i].popularity + 1;
          newestContentList.refresh();
          debugPrint("========== view count ${newestContentList[i].popularity}");
          break;

        }
      }
    }
  }


}