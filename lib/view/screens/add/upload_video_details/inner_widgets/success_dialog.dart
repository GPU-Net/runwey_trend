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
class CustomSuccessAlertBox extends StatefulWidget {
  const CustomSuccessAlertBox({super.key,required this.title,required this.subTitle});
final String title;
final String subTitle;
  @override
  State<CustomSuccessAlertBox> createState() => _CustomSuccessAlertBoxState();
}

class _CustomSuccessAlertBoxState extends State<CustomSuccessAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SizedBox(
        height: 300,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 40,),
                Column(
                  children: [
                    Text(widget.title,textAlign: TextAlign.center,style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: AppColors.black_100,) ,),
                    Text(widget.subTitle,textAlign: TextAlign.center,style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: AppColors.black_60,) ,),
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
                // left: 45,
                child: CustomImage(imageSrc: AppImages.congratsStarIcon,imageType: ImageType.png,size: 170,))
          ],
        ),
      ),
    );
  }
}