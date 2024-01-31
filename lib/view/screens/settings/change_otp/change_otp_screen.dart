import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class ChangeOtpScreen extends StatefulWidget {
  const ChangeOtpScreen({super.key});

  @override
  State<ChangeOtpScreen> createState() => _ChangeOtpScreenState();
}

class _ChangeOtpScreenState extends State<ChangeOtpScreen> {
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
              CustomText(
                text: AppStrings.oTP,
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
                    text: 'We have sent and OTP to your mail address. Please check and enter the OTP',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_100,
                    bottom: 32,
                  ),
                  PinCodeTextField(
                    cursorColor: AppColors.black_10,

                    appContext: (context),
                    validator: (value){
                      if (value!.length <= 6) {
                        return null;
                      } else {
                        return "Please enter the OTP code.";
                      }
                    },
                    autoFocus: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 53,
                      fieldWidth: 44,
                      activeFillColor: AppColors.white,
                      selectedFillColor: AppColors.white,
                      inactiveFillColor: AppColors.white,
                      borderWidth: .1,
                      errorBorderColor: AppColors.black_10,
                      selectedColor: AppColors.black_100,
                      activeColor: AppColors.black_10,
                      inactiveColor: const Color(0xFFCCCCCC),
                    ),
                    length: 6,
                    enableActiveFill: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: AppStrings.didNotGetOTP,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_100,
                      ),
                      GestureDetector(
                        onTap: () {
                          /*Get.to(()=> const OtpScreen());*/
                        },
                        child: const CustomText(
                          text: AppStrings.resendOTP,
                          fontWeight: FontWeight.w600,
                          color: AppColors.purple,

                        ),
                      ),
                    ],
                  ),

                ],
              ),
            );
          }
      ),
      bottomNavigationBar: BottomNavButton(buttonText: AppStrings.verify, onTap: (){
        Get.toNamed(AppRoute.changeUpdatePasswordScreen);
      }),
    ));
  }
}
