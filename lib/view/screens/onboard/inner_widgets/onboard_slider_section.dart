import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';

class OnboardSliderSection extends StatefulWidget {
  const OnboardSliderSection({super.key});

  @override
  State<OnboardSliderSection> createState() => _OnboardSliderSectionState();
}

class _OnboardSliderSectionState extends State<OnboardSliderSection> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  List<String> listImg = [
    AppImages.onboard1,
    AppImages.onboard2,
    AppImages.onboard3
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: listImg.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            listImg[currentIndex],
                          ),
                          fit: BoxFit.fill
                      )),


                );
              },
            );
          }).toList(),
          carouselController: carouselController,
          options: CarouselOptions(
            height: 385.h,
            scrollPhysics: const BouncingScrollPhysics(),
            autoPlay: true,
            aspectRatio: 16/9,
            viewportFraction: 1 ,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
         SizedBox(height: 24.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listImg.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => carouselController.animateToPage(entry.key),
              child: Container(
                width: currentIndex == entry.key ? 28.w
                    : 8.w,
                height: 8.h,
                margin:  EdgeInsets.symmetric(
                  horizontal: 2.w,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: currentIndex == entry.key
                        ? AppColors.purple_80
                        : AppColors.purple_20),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
