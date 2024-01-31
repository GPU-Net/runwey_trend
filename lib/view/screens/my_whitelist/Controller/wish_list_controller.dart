import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../helper/prefs_helper.dart';
import '../../../../helper/socket_maneger.dart';
import '../../../../model/wish_list_model.dart';
import '../../../../services/api_check.dart';
import '../../../../services/api_client.dart';
import '../../../../services/api_constant.dart';
import '../../../../services/socket_constant.dart';
import '../../../../utils/app_constent.dart';

class WishListController extends GetxController {
  late ScrollController scrollController;
  RxList<WishListModel> wishListContentList = <WishListModel>[].obs;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  RxList<bool> isSelectRemoveList = <bool>[].obs;
  var isSelected = false.obs;
  var isRemoveLoading=false.obs;

  selectContent(int index) {
    isSelectRemoveList[index] = !isSelectRemoveList[index];
    var isEmpty = [];
    for (int i = 0; i < isSelectRemoveList.length; i++) {
      if (isSelectRemoveList[i] == true) {
        isEmpty.add(i);
      }
    }
    if (isEmpty.isEmpty) {
      isSelected.value = false;
    }

    update();
    isSelectRemoveList.refresh();
  }

  // refreshLoad()async {
  //   page=1;
  //   Response response =
  //   await ApiClient.getData("${ApiConstant.newestContent}?page=$page",);
  //   if (response.statusCode == 200) {
  //     currentPage=response.body['data']['attributes']['pagination']['currentPage'];
  //     totalPage=response.body['data']['attributes']['pagination']['totalPages'];
  //     wishListContentList.value = List<ContentModel>.from(response.body['data']['attributes']['newestVideos'].map((x) => ContentModel.fromJson(x)));
  //
  //     isSelectRemoveList.clear();
  //     for (int i = 0; i < wishListContentList.length; i++) {
  //       isSelectRemoveList.add(false);
  //     }
  //     wishListContentList.refresh();
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  // }

  fastLoad() async {
    page = 1;
    setRxRequestStatus(Status.loading);
    Response response = await ApiClient.getData(
      "${ApiConstant.wishList}?page=$page",
    );
    if (response.statusCode == 200) {
      currentPage =
          response.body['data']['attributes']['pagination']['currentPage'];
      totalPage =
          response.body['data']['attributes']['pagination']['totalPages'];
      wishListContentList.value = List<WishListModel>.from(response.body['data']['attributes']
      ['wishlistVideos']
          .map((x) => WishListModel.fromJson(x)));
      isSelectRemoveList.clear();
      for (int i = 0; i < wishListContentList.length; i++) {
        isSelectRemoveList.add(false);
      }
      wishListContentList.refresh();
      setRxRequestStatus(Status.completed);
    }else if(response.statusCode==404){
      wishListContentList.refresh();
      setRxRequestStatus(Status.completed);
    } else {
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  loadMore() async {
    print("load more");
    if (rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false &&
        totalPage != currentPage) {
      isLoadMoreRunning(true);
      page += 1;
      Response response = await ApiClient.getData(
        "${ApiConstant.wishList}?page=$page",
      );
      currentPage =
          response.body['data']['attributes']['pagination']['currentPage'];
      totalPage =
          response.body['data']['attributes']['pagination']['totalPages'];
      if (response.statusCode == 200) {
        var demoList = List<WishListModel>.from(response.body['data']
                ['wishlistVideos']
            .map((x) => WishListModel.fromJson(x)));
        wishListContentList.addAll(demoList);
        for (int i = 0; i < wishListContentList.length; i++) {
          isSelectRemoveList.add(false);
        }
        wishListContentList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

  removeWishList() async {
    isRemoveLoading(true);
    List removeList = [];
    for (int i = 0; i < isSelectRemoveList.length; i++) {
      if (isSelectRemoveList[i] == true) {
        removeList.add(wishListContentList[i].id);
      }
    }
    List demoList= isSelectRemoveList;
    var body = {
      "videoId": removeList,
    };
    var response =
        await ApiClient.postData(ApiConstant.wishRemove, json.encode(body));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      for (int i = demoList.length - 1; i >= 0; i--) {
        if (isSelectRemoveList[i]) {
          isSelectRemoveList.removeAt(i);
          wishListContentList.removeAt(i);
        }
      }
      isSelected.value=false;
      isSelectRemoveList.refresh();
      wishListContentList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
    isRemoveLoading(false);
  }



  Future<bool> onLikeButtonTapped(bool isLiked,String videoId) async{
    var userId = await PrefsHelper.getString(AppConstants.userId);
    var data = {"userId": userId, "videoId": videoId};
    debugPrint("========== Like body $data");
    var response = await SocketApi.emitWithAck(SocketConstants.likeEvent, data);
    var success =isLiked;
    if(response['status']){
      for (int i = 0; i < wishListContentList.length; i++) {
        if (wishListContentList[i].videoId!.id == videoId) {
          if (wishListContentList[i].videoId!.isLiked==true) {
            wishListContentList[i].videoId!.likes=wishListContentList[i].videoId!.likes- 1;
            wishListContentList[i].videoId!.isLiked = false;
            wishListContentList.refresh();
            debugPrint("========== view like ${wishListContentList[i].videoId!.likes}");
            success=false;
            //  return contentList[i].isLiked!;
          } else {
            wishListContentList[i].videoId!.likes=wishListContentList[i].videoId!.likes +1;
            wishListContentList[i].videoId!.isLiked = true;
            wishListContentList.refresh();
            debugPrint("========== view like ${wishListContentList[i].videoId!.likes}");
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
      for (int i = 0; i < wishListContentList.length; i++) {
        if (wishListContentList[i].videoId!.id == videoId) {
          wishListContentList[i].videoId!.popularity =wishListContentList[i].videoId!.popularity + 1;
          wishListContentList.refresh();
          debugPrint("========== view count ${wishListContentList[i].videoId!.popularity}");
          break;

        }
      }
    }
  }

}
