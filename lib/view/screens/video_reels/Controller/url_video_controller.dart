import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../../utils/app_colors.dart';

class UrlVideoWidgetController extends GetxController{
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  var loading=false.obs;

  var isInitialized=false.obs;


  Future<void> initializePlayer(String videoPath) async {
     loading(true);
     videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoPath));
     await videoPlayerController.initialize();
     isInitialized(true);
     chewieController = ChewieController(
       videoPlayerController: videoPlayerController,
       showOptions: false,
       allowPlaybackSpeedChanging: false,
       allowedScreenSleep: false,
       allowFullScreen:false,
       autoPlay: true,
       looping: true,
       cupertinoProgressColors: ChewieProgressColors(
         playedColor: AppColors.purple,
         bufferedColor: Colors.grey,
       ),
       materialProgressColors: ChewieProgressColors(
         playedColor: AppColors.purple,
         bufferedColor: Colors.grey.shade300,
       ),
     );
     loading(false);
     update();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    isInitialized(false);
    super.dispose();
  }
}