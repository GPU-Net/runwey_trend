import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/Bindings/navbar_bindings.dart';
import 'package:runwey_trend/model/subscription_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../botttom_nav_bar/bottom_nav_bar.dart';

class PaymentStandardAlertBox extends StatefulWidget {
  const PaymentStandardAlertBox({super.key,required this.subscriptionModel});
  
  final SubscriptionModel subscriptionModel;

  @override
  State<PaymentStandardAlertBox> createState() => _PaymentStandardAlertBoxState();
}

class _PaymentStandardAlertBoxState extends State<PaymentStandardAlertBox> {
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
                const SizedBox(height: 40,),
                 Column(
                  children: [
                    const CustomText(
                      text: 'Thanks for your',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.black_100,
                    ),
                    CustomText(
                      text: 'Successful',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: colorConverter(widget.subscriptionModel.package.mainColor),
                    ),
                  ],
                ),
                CustomButton(
                  buttonWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    Get.offAll(CustomNavBar(currentIndex:0),binding: NavBarBinding());
                    // Get.back();
                    // Get.back();
                    // Get.back();
                    // Get.back();
                  },
                  titleText: 'Done',
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
                child: CustomImage(imageSrc:AppIcons.congratsSvg,imageType: ImageType.svg,size: 170,))
          ],
        ),
      ),
    );
  }

  Color colorConverter(String colorCode) => Color(int.parse(
    colorCode.replaceAll('#', '0xFF'),
  ));
}