import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import 'inner_widgets/signin_auth_section.dart';

enum RoutesEnum {
  forgetPasswordRoute,
  signUpRoute,
  homeRoute,
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  void initState() {
    DeviceUtils.screenUtils();

    super.initState();
  }
  @override
  void dispose() {

    DeviceUtils.allScreenUtils();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor: AppColors.purple,
        body: Container(
          decoration: const BoxDecoration(
            gradient:   LinearGradient(
              begin: Alignment(-0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFFFDFBFB), Colors.white, Color(0xFFF4F4F4)],
        ),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        height:Get.height,
                        width:Get.width,
                      ),
                      Container(
                        height: 326.h,
                        width: Get.width,
                        color:AppColors.purple,
                      ),
                      Column(
                        children: [
                          SizedBox(height: 103.h,),
                          SvgPicture.asset(
                            AppIcons.appLogo,
                            height:76.h, width:145.w,
                          ),
                          SizedBox(height:103.h,),
                          const SignInAuthSection(),
                        ],
                      )
                    ],
                  ),
                ),
          ),
        )
    );
  }
}
