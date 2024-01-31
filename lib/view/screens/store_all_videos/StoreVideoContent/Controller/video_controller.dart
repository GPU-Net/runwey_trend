import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController{
  late VideoPlayerController videoPlayerController;

  //
  // @override
  // void dispose() {
  //   videoPlayerController.dispose();
  //   debugPrint("video player controller dispose: Video Controller");
  //   super.dispose();
  // }
@override
  void onClose() {
    // TODO: implement onClose
  debugPrint("video player controller dispose: Video Controller");
    super.onClose();
  }


}