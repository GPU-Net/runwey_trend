import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/screens/add/Controller/controller_add_video.dart';
import 'package:runwey_trend/view/widgets/container/custom_container_card.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

class AddUploadVideoTopSection extends StatefulWidget {
  const AddUploadVideoTopSection({super.key});

  @override
  State<AddUploadVideoTopSection> createState() =>
      _AddUploadVideoTopSectionState();
}

class _AddUploadVideoTopSectionState extends State<AddUploadVideoTopSection> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // late VideoPlayerController _controller;
  // File? pickedVideo;

  // Future<void> pickVideoFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowMultiple: false,
  //       allowedExtensions: ["mp4"],
  //       type: FileType.custom);
  //
  //   if (result != null && result.files.isNotEmpty) {
  //     pickedVideo = File(result.files.single.path!);
  //     var  carREPUVEFillName = result.files.single.name;
  //
  //     // addCarDocumentsFiles =[];
  //     // addCarDocumentsFiles.add(pickedVideo!);
  //     _controller = VideoPlayerController.file(
  //         File(pickedVideo!.path)) ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });
  //   }
  // }

  final _controller = Get.put(AddVideoController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "Choose Option",
          fontSize: 18,
          color: AppColors.black_100,
          top: 12,
          bottom: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
            children:[
              Expanded(
                child: GestureDetector(
                  onTap:(){
                    _controller.picVideo(ImageSource.camera);
                  },
                  child: CustomContainerCard(
                      paddingRight: 54,
                      paddingLeft: 54,
                      paddingBottom: 22,
                      paddingTop: 22,
                      marginRight: 8,
                      marginLeft: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.purple_40, width: 1),
                        color:  AppColors.white,
                      ),
                      content: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImage(
                            imageSrc: AppIcons.videoCamera,
                            imageColor:AppColors.purple

                          ),
                          FittedBox(
                            child: CustomText(
                              text:AppStrings.record,
                              color:AppColors.purple,
                              fontSize: 14,
                              maxLines: 1,
                              fontWeight: FontWeight.w500,
                              top: 10,
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                   _controller.picVideo(ImageSource.gallery);

    },
                  child: CustomContainerCard(
                      paddingRight: 54,
                      paddingLeft: 54,
                      paddingBottom: 22,
                      paddingTop: 22,
                      marginRight: 8,
                      marginLeft: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.purple_40, width: 1),
                        color:  AppColors.purple,
                      ),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImage(
                              imageSrc: AppIcons.videoCamera,
                              imageColor:AppColors.white

                          ),
                          FittedBox(
                            child: CustomText(
                              text:AppStrings.gallery,
                              color:AppColors.white,
                              fontSize: 14,
                              maxLines: 1,
                              fontWeight: FontWeight.w500,
                              top: 10,
                            ),
                          )
                        ],
                      )),
                ),
              )
            ]
        ),
        const CustomText(
          text: "Note: Upload max of  15 sec video",
          fontSize: 10,
          color: AppColors.black_60,
          top: 12,
          bottom: 44,
        ),
      ],
    );
  }
}
