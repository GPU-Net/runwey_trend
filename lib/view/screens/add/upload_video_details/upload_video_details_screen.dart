import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/add/upload_video_details/Controller/upload_video_controller.dart';
import 'package:runwey_trend/view/screens/add/upload_video_details/inner_widgets/upload_video_details_bottom_section.dart';
import 'package:runwey_trend/view/screens/add/upload_video_details/inner_widgets/upload_video_details_middle_section.dart';
import 'package:runwey_trend/view/screens/add/upload_video_details/inner_widgets/upload_video_details_top_section.dart';
import 'package:runwey_trend/view/screens/add/upload_video_details/inner_widgets/video_widget.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_back_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/container/custom_container_card.dart';
import 'Controller/video_widget_controller.dart';

class UploadVideoDetailsScreen extends StatefulWidget {
  const UploadVideoDetailsScreen({super.key});

  @override
  State<UploadVideoDetailsScreen> createState() =>
      _UploadVideoDetailsScreenState();
}

class _UploadVideoDetailsScreenState extends State<UploadVideoDetailsScreen> {

  final videoFile=Get.arguments;
  final _uploadVideoController = Get.put(UploadVideoController());

  @override
  void initState() {
    DeviceUtils.authUtils();
    _uploadVideoController.getCategory();
    _uploadVideoController.getAutoFieldData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  validateTextField(String value) {
    if (value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const CustomAppBar(
          appBarContent: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBackButton(),
          Expanded(
            child: CustomText(
              text: AppStrings.uploadProductVideo,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              fontWeight: FontWeight.w500,
              color: AppColors.black_100,
            ),
          ),
          SizedBox()
        ],
      )),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Obx((){
          switch(_uploadVideoController.rxRequestStatus.value){
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return const Center(child: Text("Internet Error"),);
            case Status.error:
              return const Center(child: Text("General Error"),);
            case Status.completed:
              return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 225.h,
                          width: Get.width,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: FileVideoView(file:videoFile))),

                      const CustomText(
                        text: AppStrings.chooseOptionForReUpload,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_100,
                        top: 24,
                        bottom: 16,
                      ),
                      /// <--------- Choose Option for re-upload --------->
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Expanded(
                              child: GestureDetector(
                                onTap:(){
                                 _uploadVideoController.picVideo(ImageSource.camera);
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
                                  _uploadVideoController.picVideo(ImageSource.gallery);
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
                      //UploadVideoDetailsTopSection(),
                       UploadVideoDetailsMiddleSection(path:videoFile.path,),


                    ],
                  ));

          }
        });

      }),

    ));
  }
}
