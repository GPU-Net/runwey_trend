import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:runwey_trend/model/content_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/add/edit_video/inner_widgets/url_video_widget.dart';
import 'package:runwey_trend/view/widgets/container/custom_container_card.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../../video_reels/widget/url_video_widget.dart';
import '../../upload_video_details/inner_widgets/video_widget.dart';
import '../Controller/edit_product_controller.dart';

class EditVideoTopSection extends StatefulWidget {
  const EditVideoTopSection({super.key, required this.contentModel});
  final ContentModel contentModel;
  @override
  State<EditVideoTopSection> createState() => _EditVideoTopSectionState();
}

class _EditVideoTopSectionState extends State<EditVideoTopSection> {
  int selectorCategory = 0;
  List<Map<String, dynamic>> categoryList = [
    {
      "categoryIcon": AppIcons.videoCamera,
      "category": AppStrings.record,
    },
    {
      "categoryIcon": AppIcons.photograph,
      "category": AppStrings.gallery,
    },
  ];

  final _editController = Get.put(EditVideoController());

  @override
  void initState() {
    super.initState();
    debugPrint("===========> ${widget.contentModel.videoPath}");
    DeviceUtils.screenUtils();
  }

  var videoPath="";

  @override
  Widget build(BuildContext context) {
    videoPath=widget.contentModel.videoPath!;
    debugPrint(videoPath);
    return Obx(()=>
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack(
          //   children: [
          //     ClipRRect(
          //       borderRadius:
          //       const BorderRadius.all(Radius.circular(8)),
          //       child: AspectRatio(
          //         aspectRatio: _controller.value.aspectRatio,
          //         child: VideoPlayer(_controller),
          //       ),
          //     ),
          //     Positioned(
          //         top: 60,
          //         left: 130,
          //         child: IconButton(
          //             onPressed: () {
          //               setState(() {
          //                 _controller.value.isPlaying
          //                     ? _controller.pause()
          //                     : _controller.play();
          //               });
          //             },
          //             icon: Icon(
          //               size: 50,
          //               _controller.value.isPlaying
          //                   ? Icons.pause_circle_filled
          //                   : Icons.play_circle,
          //               color: Colors.white,
          //             )))
          //   ],
          // ),
          _editController.videoFilePath.value.isEmpty
              ? EditUrlVideoView(
                  url: widget.contentModel.videoPath??"", thumbnail:widget.contentModel.thumbnailPath??"",
                )
              : SizedBox(
                  height: 225.h,
                  width: Get.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: FileVideoView(
                          file: File(_editController.videoFilePath.value)))),

          const CustomText(
            text: AppStrings.chooseOptionForReUpload,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.black_100,
            top: 24,
            bottom: 16,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Expanded(
                  child: GestureDetector(
                    onTap:(){
                      _editController.picVideo(ImageSource.camera);
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
                      _editController.picVideo(ImageSource.gallery);

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
                        content: const Column(
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
        ],
      ),
    );
  }
}
