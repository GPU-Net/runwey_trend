
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/prefs_helper.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/utils/style.dart';
import 'package:runwey_trend/view/screens/onboard/inner_widgets/onboard_slider_section.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  List<String> listImg = [
    AppImages.onboard1,
    AppImages.onboard2,
    AppImages.onboard3
  ];

  @override
  void initState() {
    DeviceUtils.imageUtils();
    super.initState();
  }
  @override
  void deactivate() {
    DeviceUtils.screenUtils();
    super.deactivate();
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return  Column(
            children: [
              const OnboardSliderSection(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height:24.h,),
                    Text(AppStrings.discoverTrends,style:AppStyles.h2(),),
                    SizedBox(height: 24.h,),
                    Text(AppStrings.loremIpsumDolor,style:AppStyles.h5(),maxLines: 3,textAlign: TextAlign.center,),
                    SizedBox(height: 147.h,),
                    NewCustomButton(onTap:(){
                      Get.offAndToNamed(AppRoute.signInScreen);
                      PrefsHelper.setBool(AppConstants.onBoard, true);
                    }, text:AppStrings.getStarted),

                  ],
                ),
              ),


            ],
          );
        },
      ),
    ));
  }
}

// class CliperCustom extends CustomClipper<Path>{
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height-150);
//     path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-150);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
//
// }
