import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/helper/notification_helper.dart';
import 'package:runwey_trend/helper/prefs_helper.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/view/screens/profile/Controller/profile_controller.dart';
import 'package:runwey_trend/view/screens/video_reels/Controller/video_reels_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../main.dart';


///<------------------------- Socket Class ---------------->
class SocketApi {
  // Factory constructor to return the same static instance every time you create an object.
  factory SocketApi() {
    return _socketApi;
  }

  // An internal private constructor to access it only once for the static instance of the class.
  SocketApi._internal();

  ///<------------------------- Socket Initialization ---------------->
  static void init() {
    debugPrint(
        '=============> Socket initialization, connected: ${socket.connected}');
    if (!socket.connected) {
      // socket.connect();
      socket.onConnect((_) {
        debugPrint('===============> Socket Connected');
      });
      // socket.on('APP::CHAT::THREAD::LIST::LATEST::UNREAD', (dynamic data) {
      //   print('Socket instance created and connected');
      //  // socket.emit('user:connected', <dynamic, dynamic>{'user': Environment.user});
      // });
      // socket.on('unauthorized', (dynamic data) {
      //   print('Unauthorized');
      // });
      // socket.onError((dynamic error) {
      //   print('Socket error: $error');
      // });
      // socket.onDisconnect((dynamic data) {
      //   print('Socket instance disconnected');
      // });
    } else {
      debugPrint('Socket instance already connected');
    }
  }

  static final SocketApi _socketApi = SocketApi._internal();

  ///<------------------------- Socket Client ---------------->

  static IO.Socket socket = IO.io(
    ApiConstant.socketUrl,
    IO.OptionBuilder().setTransports(['websocket'])
    //   .disableAutoConnect()
    //    .enableForceNewConnection()
    //    .setTimeout(5000)
    //    .setReconnectionDelay(10000)
    //    .enableReconnection()
    // .setQuery(<dynamic, dynamic>{'token': Environment.token})
        .build(),
  );

  ///<------------------------- Send Message and Response ---------------->


  static Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();

    socket.emitWithAck(event, body, ack: (data) {
      if (data != null) {
        debugPrint('===========> Emit With Ack $data');
        completer.complete(data);
      } else {
        debugPrint('===========> Null');
        completer.complete(1); // You can specify the default value when null
      }
    });
    return completer.future;
  }


  ///<------------------------- Send Message ---------------->

  static emit(String event, dynamic body) {
    if (body != null) {
      socket.emit(event, body);
      debugPrint('===========> Emit');
    }
  }


  static var userId="";

static listenSubscription()async{

  userId = await PrefsHelper.getString(AppConstants.userId);



    socket.on("user-notification::$userId", (data){

      debugPrint("Notification Response : $data");
      NotificationHelper.showNotification(body: data, fln: fln);

      if(data['type']=="my-subscription"){
        Get.put(ProfileController()).getProfileData();
      }
    });

}



}