import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/view/widgets/cache_nerwork_image.dart';
import 'package:video_player/video_player.dart';
import '../Controller/url_video_controller.dart';

class UrlVideoView extends StatefulWidget {
  const UrlVideoView({super.key, required this.url,required this.thumbnail});
  final String url;
  final String thumbnail;
  @override
  State<UrlVideoView> createState() => _UrlVideoViewState();
}

class _UrlVideoViewState extends State<UrlVideoView> {
  final _videoWidgetController = Get.put(SimilarUrlVideoWidgetController());
  @override
  void initState() {
      _videoWidgetController.initializePlayer(widget.url);
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
    debugPrint("Video player controller value file : ${widget.url}");
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.grey.shade300,
        ),
        height: 225.h,
        width: Get.width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Obx(() => _videoWidgetController.loading.value
                ? CustomNetworkImage(imageUrl:widget.thumbnail, height:double.maxFinite, width:double.infinity,child:const Center(child: CircularProgressIndicator(color: AppColors.purple,),),)
                : _videoWidgetController
                        .videoPlayerController.value.isInitialized
                    ? Chewie(
                        controller: _videoWidgetController.chewieController,
                      )
                    : const SizedBox())));
    // return Obx(() => _videoWidgetController.loading.value?Container(
    //   color: Colors.grey.shade300,
    // ): _videoWidgetController.videoPlayerController.value.isInitialized
    //     ? Chewie(
    //   controller: _videoWidgetController.chewieController,
    // )
    //     : const SizedBox());
  }
}
