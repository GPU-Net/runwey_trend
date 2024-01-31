import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/view/screens/add/upload_video_details/Controller/video_widget_controller.dart';
import 'package:video_player/video_player.dart';

class FileVideoView extends StatefulWidget {
  const FileVideoView({super.key, required this.file});
  final File file;
  @override
  State<FileVideoView> createState() => _FileVideoViewState();
}

class _FileVideoViewState extends State<FileVideoView> {
 final _videoWidgetController = Get.put(VideoWidgetController());
  @override
  void initState() {
   _videoWidgetController.initializePlayer(widget.file.path);
   setState(() {

   });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoWidgetController.videoPlayerController.dispose();
   _videoWidgetController.chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Video player controller value file : ${widget.file.path}");
    return Obx(() => _videoWidgetController.loading.value?Container(
      color: Colors.grey.shade300,
    ): _videoWidgetController.videoPlayerController.value.isInitialized
        ? Chewie(
      controller: _videoWidgetController.chewieController,
    )
        : const SizedBox());
  }
}
