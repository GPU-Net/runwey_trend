 import 'package:flutter/material.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class AdminPermitSection extends StatefulWidget {
  const AdminPermitSection({super.key});

  @override
  State<AdminPermitSection> createState() => _AdminPermitSectionState();
}

class _AdminPermitSectionState extends State<AdminPermitSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomImage(
            imageSrc: AppImages.pleaseWait,
            imageType: ImageType.png,
            size: 150,
          ),
         CustomText(
           text: AppStrings.pleaseWait,
           fontWeight: FontWeight.w600,
           fontSize: 22,
           color: AppColors.black_100,
           top: 24,
           bottom: 12,
         ),
          CustomText(
            text: AppStrings.adminIsNotApprovedYet,
            color: AppColors.black_60,
          ),


        ],
      ),
    );
  }
}
