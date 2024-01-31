import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
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
      appBar: CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(),
              CustomText(
                text: AppStrings.support,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.black_100,
              ),
              SizedBox()
            ],
          )),
      body: LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            return const SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: '1.',
                          color: AppColors.black_100,
                          right: 4,
                        ),

                        Expanded(
                          child: CustomText(
                            maxLines: 3,
                            text: AppStrings.loremIpsumDolor,
                            color: AppColors.black_100,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: '2.',
                          color: AppColors.black_100,
                          right: 4,
                        ),

                        Expanded(
                          child: CustomText(
                            maxLines: 3,
                            text: AppStrings.loremIpsumDolor,
                            color: AppColors.black_100,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: '3.',
                          color: AppColors.black_100,
                          right: 4,
                        ),

                        Expanded(
                          child: CustomText(
                            maxLines: 3,
                            text: AppStrings.loremIpsumDolor,
                            color: AppColors.black_100,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: '4.',
                          color: AppColors.black_100,
                          right: 4,
                        ),

                        Expanded(
                          child: CustomText(
                            maxLines: 3,
                            text: AppStrings.loremIpsumDolor,
                            color: AppColors.black_100,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: '5.',
                          color: AppColors.black_100,
                          right: 4,
                        ),

                        Expanded(
                          child: CustomText(
                            maxLines: 3,
                            text: AppStrings.loremIpsumDolor,
                            color: AppColors.black_100,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            );
          }
      ),
    ));
  }
}
