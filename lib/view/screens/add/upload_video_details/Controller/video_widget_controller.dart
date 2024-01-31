import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../../utils/app_colors.dart';

class VideoWidgetController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  var loading = false.obs;

  Future<void> initializePlayer(String videoPath) async {
    loading(true);

    videoPlayerController = VideoPlayerController.file(File(videoPath));
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      showOptions: false,
      allowPlaybackSpeedChanging: false,
      allowedScreenSleep: false,
      cupertinoProgressColors: ChewieProgressColors(
        playedColor: AppColors.purple,
        bufferedColor: Colors.grey,
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.purple,
        bufferedColor: Colors.grey.shade300,
      ),
      autoInitialize: true,
    );
    loading(false);
    update();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
