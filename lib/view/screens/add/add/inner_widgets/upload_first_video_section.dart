import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/screens/add/Controller/controller_add_video.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class UploadFirstVideoSection extends StatefulWidget {
  const UploadFirstVideoSection({super.key});

  @override
  State<UploadFirstVideoSection> createState() => _UploadFirstVideoSectionState();
}

class _UploadFirstVideoSectionState extends State<UploadFirstVideoSection> {

  final _addVideoController =Get.put(AddVideoController());

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomImage(
            imageSrc: AppImages.illustration,
            imageType: ImageType.png,
            size: 150,
          ),
          const CustomText(
            text: AppStrings.noVideosYet,
            color: AppColors.purple_80,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            top: 16,
            bottom: 8,
          ),
          const CustomText(
            text: AppStrings.exploreTheMoments,
            color: AppColors.black_60,
            fontSize: 12,
            bottom: 4,
          ),
          const CustomText(
            text: AppStrings.upload10sVideo,
            color: AppColors.black_60,
            fontSize: 10,
            bottom: 16,
          ),
          CustomButton(
            onPressed: () {
             _addVideoController.picVideo(ImageSource.gallery);

            },
            titleText: AppStrings.upload,
            titleColor: AppColors.white,
            buttonBgColor: AppColors.purple,
            titleSize: 16,
            titleWeight: FontWeight.w600,
            topPadding: 12,
            bottomPadding: 12,
            leftPadding: 70,
            rightPadding: 70,
          ),
        ],
      ),
    );
  }
}
