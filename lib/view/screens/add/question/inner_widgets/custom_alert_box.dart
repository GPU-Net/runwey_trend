import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/Bindings/navbar_bindings.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../botttom_nav_bar/bottom_nav_bar.dart';
class CustomAlertBox extends StatefulWidget {
  const CustomAlertBox({super.key});

  @override
  State<CustomAlertBox> createState() => _CustomAlertBoxState();
}

class _CustomAlertBoxState extends State<CustomAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        height: 300,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 40,),
                const Column(
                  children: [
                    CustomText(
                      text: 'Thanks for your',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.black_100,
                    ),
                    CustomText(
                      text: 'Response',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.black_100,
                    ),
                    CustomText(
                      text: AppStrings.waitingForAdminApproval,
                      fontSize: 12,
                      color: AppColors.black_60,
                      bottom: 58,
                      top: 4,
                    ),
                  ],
                ),
                CustomButton(
                  buttonWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    Get.offAll(CustomNavBar(currentIndex:0),binding: NavBarBinding());
                  },
                  titleText: AppStrings.backToHome,
                  titleColor: AppColors.white,
                  buttonBgColor: AppColors.purple,
                  titleSize: 18,
                  titleWeight: FontWeight.w600,
                  topPadding: 12,
                  bottomPadding: 12,
                )
              ],
            ),
            const Positioned(
                top:-103,
                left: 45,
                child: CustomImage(imageSrc: AppImages.congratsStarIcon,imageType: ImageType.png,size: 170,))
          ],
        ),
      ),
    );
  }
}