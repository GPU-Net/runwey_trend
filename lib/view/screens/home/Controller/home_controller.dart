import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/helper/socket_maneger.dart';
import 'package:runwey_trend/model/banner_model.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:runwey_trend/view/screens/home/Controller/newest_controller.dart';
import 'package:runwey_trend/view/screens/home/Controller/popular_controller.dart';
import 'package:runwey_trend/view/screens/profile/Controller/profile_controller.dart';

import '../../../../helper/prefs_helper.dart';
import '../../../../model/content_model.dart';
import '../../../../model/video_list_model.dart';
import '../../../../utils/app_constent.dart';
import '../../../../utils/app_strings.dart';

class HomeController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  // RxList<ContentModel> newestVideoList= <ContentModel>[].obs;
  // RxList<ContentModel> popularVideoList= <ContentModel>[].obs;
  Rx<BannerModel> bannerModel=BannerModel().obs;
 NewestController newestController= Get.put(NewestController());
 PopularController popularController= Get.put(PopularController());

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  @override
  void onInit() {
    getData(true);
    SocketApi.listenSubscription();
    super.onInit();
  }

  getData(bool isLoading) async {


   await selectGender();
    await getBanner(isLoading);

  }
  selectGender()async{
    String gender= await PrefsHelper.getString(AppStrings.gender);
    newestController.selectGender.value =gender.isNotEmpty?gender:"All";
    popularController.selectGender.value =gender.isNotEmpty?gender:"All";
    newestController.fastLoad();
    popularController.fastLoad();
  }
  // getNewestVideo(bool isLoading) async {
  //   if(isLoading){
  //     setRxRequestStatus(Status.loading);
  //   }
  //
  //   var response = await ApiClient.getData(ApiConstant.newestContent);
  //   if (response.statusCode == 200) {
  //     newestVideoList.value=List<ContentModel>.from(response.body['data']['attributes']['newestVideos'].map((x) => ContentModel.fromJson(x)));
  //     await getBanner(isLoading);
  //     newestVideoList.refresh();
  //     update();
  //   } else {
  //     if(isLoading){
  //       if (ApiClient.noInternetMessage == response.statusText) {
  //         setRxRequestStatus(Status.internetError);
  //       } else {
  //         setRxRequestStatus(Status.error);
  //       }
  //     }
  //
  //     //ApiChecker.checkApi(response);
  //   }
  // }

  getBanner(bool isLoading) async {
    if(isLoading){
      setRxRequestStatus(Status.loading);
    }
    var response = await ApiClient.getData(ApiConstant.banner);
    if (response.statusCode == 200) {
      bannerModel.value= BannerModel.fromJson(response.body);
      setRxRequestStatus(Status.completed);
    } else {
      if(isLoading){
        if (ApiClient.noInternetMessage == response.statusText) {
          setRxRequestStatus(Status.internetError);
        } else {
          setRxRequestStatus(Status.error);
        }
      }
      //ApiChecker.checkApi(response);
    }
  }

  // getPopularVideo(bool isLoading) async {
  //   if(isLoading){
  //     setRxRequestStatus(Status.loading);
  //   }
  //   var response = await ApiClient.getData(ApiConstant.popularContent);
  //   if (response.statusCode == 200) {
  //     popularVideoList.value=List<ContentModel>.from(response.body['data']['attributes']['popularContent'].map((x) => ContentModel.fromJson(x)));
  //     setRxRequestStatus(Status.completed);
  //     popularVideoList.refresh();
  //     update();
  //   } else {
  //     if(isLoading){
  //       if (ApiClient.noInternetMessage == response.statusText) {
  //         setRxRequestStatus(Status.internetError);
  //       } else {
  //         setRxRequestStatus(Status.error);
  //       }
  //     }
  //   //  ApiChecker.checkApi(response);
  //   }
  // }


}
