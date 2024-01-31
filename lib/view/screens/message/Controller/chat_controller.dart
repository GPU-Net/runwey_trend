import 'dart:async';
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/helper/prefs_helper.dart';
import 'package:runwey_trend/helper/socket_maneger.dart';
import 'package:runwey_trend/model/chat_model.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:runwey_trend/services/socket_constant.dart';

import '../../../../services/api_check.dart';
import '../../../../utils/app_constent.dart';

class ChatController extends GetxController {
  late ScrollController scrollController;
  TextEditingController messageCtrl = TextEditingController();
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  int page = 1;
  var isLoadMoreRunning = false.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  var isFabButton = false.obs;

  listenMessage(String chatId) async {
    SocketApi.socket.on("new-message::$chatId", (data) {
      ChatModel demoData = ChatModel.fromJson(data);
      if (userId != demoData.sender!.id) {
        chatList.add(demoData);
        chatList.refresh();
        update();
        debugPrint("=========> Response Message $data");
      }
    });
  }

  offSocket(String chatId) {
    SocketApi.socket.off("new-message::$chatId");
    debugPrint("Socket off New message");
  }

  fastLoad(String chatId) async {
    page = 1;
    setRxRequestStatus(Status.loading);
    Response response =
        await ApiClient.getData("${ApiConstant.message + chatId}?page=$page");
    if (response.statusCode == 200) {
      currentPage = response.body['data']['attributes']['page'];
      totalPage = response.body['data']['attributes']['totalPages'];
      chatList.value = List<ChatModel>.from(response.body['data']['attributes']
              ['data']
          .map((x) => ChatModel.fromJson(x)));
      chatList.refresh();
      setRxRequestStatus(Status.completed);
      if(chatList.isNotEmpty){
        scrollTime();
      }

      update();
    } else {
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  loadMore(String chatId) async {
    print("load more");
    if (rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false &&
        totalPage != currentPage) {
      isLoadMoreRunning(true);
      page += 1;
      Response response =
          await ApiClient.getData("${ApiConstant.message + chatId}?page=$page");
      currentPage = response.body['data']['attributes']['page'];
      totalPage = response.body['data']['attributes']['totalPages'];
      if (response.statusCode == 200) {
        var demoList = List<ChatModel>.from(response.body['data']['attributes']
                ['data']
            .map((x) => ChatModel.fromJson(x)));
        chatList.addAll(demoList);
        chatList.refresh();
        update();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

  ///  get user id
  String userId = "";

  getUserId() async {
    userId = await PrefsHelper.getString(AppConstants.userId);
    debugPrint("=========> User Id $userId");
  }

  ///  send message

  sendMessage(String message, {required String chatId}) async {
    var body = {
      "chat": chatId,
      "sender": userId,
      "receiver": "admin",
      "message": message
    };
    var response =
        await SocketApi.emitWithAck(SocketConstants.newMessageEvent, body);
    if (response['status'] == "Success") {
      ChatModel demoData = ChatModel.fromJson(response['message']);
      chatList.add(demoData);
      chatList.refresh();
      update();
      messageCtrl.clear();
      scrollToEnd();
    }
  }

  ///  scroll bottom and end
  scrollToEnd() {
    Timer(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 100), curve: Curves.decelerate);
      }
    });
  }

  ///  scroll fast time
  scrollTime() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
    });
  }
}
