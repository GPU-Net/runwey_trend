import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../helper/prefs_helper.dart';
import '../../../../../model/content_details_model.dart';
import '../../../../../utils/app_constent.dart';
import '../../../SimilarVideoContent/Controller/video_reels_controller.dart';



class WishListContentDetailsController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  final SimilarVideoReelsController _similarVideoReelsController=Get.put(SimilarVideoReelsController());

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  Rx<ContentDetailsModel> contentDetailsModel = ContentDetailsModel().obs;
  var rating = 0.0.obs;
  var ratingLoading = false.obs;
  TextEditingController feedbackController = TextEditingController();


  feedBack(String id) async {
    ratingLoading(true);
    var body = {

      "rating": rating.value.toString(),
      "message": feedbackController.text
    };
    var response = await ApiClient.postData(
        ApiConstant.rating + id, json.encode(body));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Rating successfully");
      feedbackController.clear();
      rating.value = 1;
      Get.back();
    }
    ApiChecker.checkApi(response);
    ratingLoading(false);
  }

  feedBackState(Reviews reviews) async {
    contentDetailsModel.value.attributes?.reviews!.insert(0, reviews);
    contentDetailsModel.refresh();
    update();
  }

  getProductsDetails(String id, bool isLoading) async {
    if (isLoading) {
      setRxRequestStatus(Status.loading);
    }

    var response = await ApiClient.getData(ApiConstant.contentDetails + id);
    if (response.statusCode == 200) {
      contentDetailsModel.value =
          ContentDetailsModel.fromJson(response.body['data']);
      await _similarVideoReelsController.getVideoList(id);
      setRxRequestStatus(Status.completed);
    } else {
      if (isLoading) {
        if (ApiClient.noInternetMessage == response.statusText) {
          setRxRequestStatus(Status.internetError);
        } else {
          setRxRequestStatus(Status.error);
        }
        ApiChecker.checkApi(response);
      }
    }
  }

  var wishListAddLoading = false.obs;

  addWishList(String id) async {
    wishListAddLoading(true);
    var body = {"videoId": id};
    var response =
    await ApiClient.postData(ApiConstant.addWishList, json.encode(body));
    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.body['message']);
    } else {
      ApiChecker.checkApi(response, getXSnackBar: true);
      // Fluttertoast.showToast(msg: response.body['message']);
    }
    wishListAddLoading(false);
  }



}