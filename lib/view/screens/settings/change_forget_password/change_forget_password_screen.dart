import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class ChangeForgetPasswordScreen extends StatefulWidget {
  const ChangeForgetPasswordScreen({super.key});

  @override
  State<ChangeForgetPasswordScreen> createState() => _ChangeForgetPasswordScreenState();
}

class _ChangeForgetPasswordScreenState extends State<ChangeForgetPasswordScreen> {
  @override
  void initState() {
    DeviceUtils.authUtils();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar:  CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(),
              CustomText(
                text: AppStrings.forgetPassword,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.black_100,
              ),
              SizedBox()
            ],
          )),
      body: LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    text: 'Enter your E-mail address to verify OTP',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_100,
                  ),
                  const CustomText(
                    text: AppStrings.email,
                    color: AppColors.black_100,
                    fontWeight: FontWeight.w400,
                    top: 20,
                    bottom: 8,
                  ),
                  CustomTextField(
                    textAlign: TextAlign.start,
                    hintText: AppStrings.enterYourEmail,
                    hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_40),
                    inputTextStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.black_100),
                    fieldBorderColor: AppColors.black_10,
                    fieldBorderRadius: 8,

                  ),

                ],
              ),
            );
          }
      ),
      bottomNavigationBar: BottomNavButton(buttonText: 'Send OTP', onTap: (){
        Get.toNamed(AppRoute.changeOtpScreen);
      }),
    ));
  }
}
