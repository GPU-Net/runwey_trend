import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/botttom_nav_bar/bottom_nav_bar.dart';
import 'package:runwey_trend/view/screens/home/Controller/home_controller.dart';
import 'package:runwey_trend/view/screens/home/home/inner_widgets/home_newest_section.dart';
import 'package:runwey_trend/view/screens/home/home/inner_widgets/home_popular_section.dart';
import 'package:runwey_trend/view/screens/home/home/inner_widgets/home_slider_section.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../Controller/newest_controller.dart';
import '../Controller/popular_controller.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = Get.put(HomeController());
  NewestController newestController= Get.put(NewestController());
  PopularController popularController= Get.put(PopularController());



  @override
  void initState() {
    DeviceUtils.authUtils();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceUtils.whiteUtils();
    return Obx(() {
      switch (_homeController.rxRequestStatus.value) {
        case Status.loading:
          return const CustomLoader();
        case Status.internetError:
          return NoInternetScreen(onTap:(){
            _homeController.getData(true);
          });
        case Status.error:
          return GeneralErrorScreen(onTap: (){
            _homeController.getData(true);
          });
        case Status.completed:
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    // SvgPicture.asset(
                    //   AppIcons.runweyTextLogoSvg,),
                      Spacer(),
                      Row(
                        children: [
                          // InkWell(
                          //     onTap: () {
                          //    setState(() {
                          //      CustomNavBar(currentIndex: 1);
                          //    });
                          //        Get.to(CustomNavBar(currentIndex: 1));
                          //     },
                          //     child: CustomImage(
                          //       imageSrc: AppIcons.search,
                          //       size: 18.sp,
                          //       imageColor: AppColors.black_100,
                          //     )),
                          SizedBox(
                            width: 24.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoute.notificationScreen);
                              },
                              child:CustomImage(
                                imageSrc: AppIcons.bell,
                                size: 25.sp,
                                imageColor: AppColors.black_100,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: RefreshIndicator(

                      onRefresh: () async{
                        _homeController.getData(false);
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w,),
                          child: const HomeSliderSection(),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: 'Newest',
                                color: AppColors.black_100,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.newestScreen);
                                },
                                child: const CustomText(
                                  text: AppStrings.seeAll,
                                  color: AppColors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                              HomeNewestSection(),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: AppStrings.popular,
                                color: AppColors.black_100,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.popularScreen);
                                },
                                child: const CustomText(
                                  text: AppStrings.seeAll,
                                  color: AppColors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                         HomePopularSection(),
                        SizedBox(
                          height: 100.h,
                        )
                      ],
                                        ),
                                      ),
                    ))
              ],
            );
          });
      }
    }

    );
  }
}
