import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/notification_model.dart';
import '../../../../services/api_check.dart';
import '../../../../services/api_client.dart';
import '../../../../services/api_constant.dart';
import '../../../../utils/app_constent.dart';

class  NotificationController extends GetxController{
  late ScrollController  scrollController;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var totalPage=(-1);
  var currentPage=(-1);
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;


  fastLoad()async {
    page=1;
    setRxRequestStatus(Status.loading);
    Response response = await ApiClient.getData("${ApiConstant.notification}?page=$page",);
    if (response.statusCode == 200) {
      currentPage=response.body['data']['attributes']['pagination']['page'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      notificationList.value = List<NotificationModel>.from(response.body['data']['attributes']['notifications'].map((x) => NotificationModel.fromJson(x)));
      notificationList.refresh();
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

  loadMore() async {
    print("load more");
    if (rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false&&totalPage != currentPage) {
      isLoadMoreRunning(true);
      page += 1;
      Response response = await ApiClient.getData("${ApiConstant.notification}?page=$page",);
      currentPage=response.body['data']['attributes']['pagination']['page'];
      totalPage=response.body['data']['attributes']['pagination']['totalPages'];
      if (response.statusCode == 200) {
        var demoList = List<NotificationModel>.from(response.body['data']['attributes']['notifications'].map((x) => NotificationModel.fromJson(x)));
        notificationList.addAll(demoList);
        notificationList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }}










}