import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/auth/sign_up/sign_up_auth_section.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_back_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    DeviceUtils.allScreenUtils();
    super.initState();
  }
  @override
  void dispose() {
    DeviceUtils.screenUtils();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.whiteBg,
      appBar:AppBar(
        title: const Text(AppStrings.signUp),
        leading: const CustomBackButton(),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
          padding:  EdgeInsets.symmetric( horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:24.h,),
              const SignUpAuthSection(),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: AppStrings.alreadyHaveAnAccount,
                    color: AppColors.black_100,
                    top: 16,
                    bottom: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const CustomText(
                      text: AppStrings.signIn,
                      color: AppColors.purple,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      top: 16,
                      bottom: 16,
                      left: 4,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
