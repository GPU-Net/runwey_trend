import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';

class ContentCreatorSection extends StatefulWidget {
  const ContentCreatorSection({super.key});

  @override
  State<ContentCreatorSection> createState() => _ContentCreatorSectionState();
}

class _ContentCreatorSectionState extends State<ContentCreatorSection> {
  @override
  Widget build(BuildContext context) {
    return   Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomImage(
            imageSrc: AppImages.applyAsContent,
            imageType: ImageType.png,
            size: 150,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            onPressed: (){
              Get.toNamed(AppRoute.questionScreen);
            },
            titleText: AppStrings.applyAsContentCreator,
            titleColor: AppColors.white,
            buttonBgColor: AppColors.purple,
            titleSize: 16,
            titleWeight: FontWeight.w600,
            topPadding: 12,
            bottomPadding: 12,
            leftPadding: 16,
            rightPadding: 16,
          ),
        ],
      ),
    );
  }
}
