import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/helper/prefs_helper.dart';
import 'package:runwey_trend/helper/socket_maneger.dart';
import 'package:runwey_trend/model/video_list_model.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:runwey_trend/services/socket_constant.dart';
import 'package:video_player/video_player.dart';

import '../../../../../model/content_model.dart';
import '../../../../../utils/app_constent.dart';


class WishListVideoReelsController extends GetxController {




  RxList<ContentModel> contentList = <ContentModel>[].obs;
  var loading = true.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  int page = 1;
  var subscriptionType="Regular".obs;

  getSubscription()async{
   subscriptionType.value = await PrefsHelper.getString(AppConstants.subscriptionType);
  }

  getVideoList(String contentId) async {
    loading(true);
    var response = await ApiClient.getData(
        "${ApiConstant.wishListContent + contentId}?page=$page");
    if (response.statusCode == 200) {
      contentList.value = List<ContentModel>.from(response.body['data']
              ['attributes']['wishListedVideos']
          .map((x) => ContentModel.fromJson(x['videoId'])));

      totalPage =
          response.body['data']['attributes']['pagination']['totalPages'];
      currentPage =
          response.body['data']['attributes']['pagination']['currentPage'];
      contentList.refresh();
      handleView(contentId);
      //handleView("657c13d2c7bef712cd981dfa");
      loading(false);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  loadMoreGetVideoList(String contentId) async {
    if (loading.value == false && totalPage != currentPage) {
      page++;
      loading(true);
      var response = await ApiClient.getData(
          "${ApiConstant.wishListContent + contentId}?page=$page");
      if (response.statusCode == 200) {
        List<ContentModel> demoList = List<ContentModel>.from(response
            .body['data']['attributes']['wishListedVideos']
            .map((x) => ContentModel.fromJson(x['videoId'])));
        totalPage =
            response.body['data']['attributes']['pagination']['totalPages'];
        currentPage =
            response.body['data']['attributes']['pagination']['currentPage'];
        contentList.addAll(demoList);
        contentList.refresh();
        loading(false);
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }
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
