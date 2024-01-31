import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/view/screens/home/Controller/home_controller.dart';
import 'package:runwey_trend/view/widgets/cache_nerwork_image.dart';

class HomeSliderSection extends StatefulWidget {
  const HomeSliderSection({super.key});

  @override
  State<HomeSliderSection> createState() => _HomeSliderSectionState();
}

class _HomeSliderSectionState extends State<HomeSliderSection> {
  final _homeController = Get.put(HomeController());
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();
  List<String> listImg = [AppImages.banner, AppImages.banner, AppImages.banner];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _homeController.bannerModel.value.data!.bannersData!.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomNetworkImage(
                    imageUrl: i.bannerImage ?? "",
                    height: double.maxFinite,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
                // return Container(
                //   margin: const EdgeInsets.only(right: 5),
                //   width: MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       color: Colors.brown,
                //       image: DecorationImage(
                //         image: AssetImage(
                //           listImg[currentIndex],
                //         ),
                //         fit: BoxFit.cover,
                //       )),
                // );
              },
            );
          }).toList(),
          carouselController: carouselController,
          options: CarouselOptions(
            height: 150,
            scrollPhysics: const BouncingScrollPhysics(),
            autoPlay: true,
            aspectRatio: 2,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listImg.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => carouselController.animateToPage(entry.key),
              child: Container(
                width: currentIndex == entry.key ? 28 : 8,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
