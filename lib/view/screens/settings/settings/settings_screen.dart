import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/container/custom_container_card.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    DeviceUtils.authUtils();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar:  CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(),
              const CustomText(
                text: AppStrings.settings,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.black_100,
              ),
              const SizedBox()
            ],
          )),
      body: LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.changePassword);
                    },
                    child: CustomContainerCard(
                        marginBottom: 8,
                      paddingTop: 16,
                        paddingBottom: 16,
                        paddingLeft: 16,
                        paddingRight: 16,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1,color: AppColors.black_60)
                        ) ,
                        content: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.changePassword,
                              color: AppColors.black_100,
                            ),
                            CustomImage(imageSrc: AppIcons.forwardIcon,size: 18,imageColor: AppColors.black_100,)
                          ],
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.termsServicesScreen);
                    },
                    child: CustomContainerCard(
                      marginBottom: 8,
                      paddingTop: 16,
                        paddingBottom: 16,
                        paddingLeft: 16,
                        paddingRight: 16,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1,color: AppColors.black_60)
                        ) ,
                        content: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.termsOfServices,
                              color: AppColors.black_100,
                            ),
                            CustomImage(imageSrc: AppIcons.forwardIcon,size: 18,imageColor: AppColors.black_100,)
                          ],
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.privacyPolicyScreen);
                    },
                    child: CustomContainerCard(
                        marginBottom: 8,
                        paddingTop: 16,
                        paddingBottom: 16,
                        paddingLeft: 16,
                        paddingRight: 16,
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1,color: AppColors.black_60)
                        ) ,
                        content: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.privacyPolicy,
                              color: AppColors.black_100,
                            ),
                            CustomImage(imageSrc: AppIcons.forwardIcon,size: 18,imageColor: AppColors.black_100,)
                          ],
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.aboutUsScreen);
                    },
                    child: CustomContainerCard(
                        paddingTop: 16,
                        paddingBottom: 16,
                        paddingLeft: 16,
                        paddingRight: 16,
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1,color: AppColors.black_60)
                        ) ,
                        content: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.aboutUs,
                              color: AppColors.black_100,
                            ),
                            CustomImage(imageSrc: AppIcons.forwardIcon,size: 18,imageColor: AppColors.black_100,)
                          ],
                        )
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    ));
  }
}
