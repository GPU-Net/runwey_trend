import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:get/get.dart';


import 'package:runwey_trend/helper/AdMob/ad_display.dart';
import 'package:runwey_trend/utils/app_colors.dart';

import 'package:runwey_trend/view/screens/category_by_content/VideoReals/tiktok_video_controller.dart';
import 'package:runwey_trend/view/screens/my_whitelist/video_reels/tiktok_video_controller.dart';


import '../../../widgets/custom_video_loader.dart';
import '../Controller/wish_list_controller.dart';


class WishListVideoReelsScreen extends StatefulWidget {
  const WishListVideoReelsScreen(
      {Key? key, required this.initIndex, })
      : super(key: key);
  final int initIndex;
  @override
  State<WishListVideoReelsScreen> createState() =>
      _WishListVideoReelsScreenState();
}

class _WishListVideoReelsScreenState
    extends State<WishListVideoReelsScreen> {
  late PageController pageController;

  final _videoReelsController = Get.put(WishListController());
  var _currentPage=0;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (_videoReelsController.wishListContentList.length - 1 == widget.initIndex) {
        _videoReelsController.loadMore();
      }

      pageController = PageController(initialPage: widget.initIndex);


    });
    _currentPage=widget.initIndex;
    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (newPage != _currentPage) {
        // Page changed
        if (newPage > _currentPage) {
          // Going forward, increment the counter

          if((newPage+1)%7==0){
            debugPrint("=========> Show ads ");
            AdDisplay().loadRewarded();
          }
          debugPrint("=========> current page ${_currentPage} newPage ${newPage}");
        }
      }
      _currentPage = newPage;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: pageController,
              itemCount: _videoReelsController.isLoadMoreRunning.value
                  ? _videoReelsController.wishListContentList.length + 1
                  : _videoReelsController.wishListContentList.length,
              onPageChanged: (int page) {
                debugPrint("=========> Page Number : $page");
                if (_videoReelsController.wishListContentList.length > page) {
                  _videoReelsController.handleView(
                      _videoReelsController.wishListContentList[page].videoId!.id!);
                  //  _videoReelsController.handleView("657c13d2c7bef712cd981dfa");
                  if (page ==
                      _videoReelsController.wishListContentList.length - 1) {
                    _videoReelsController.loadMore();
                    debugPrint(
                        "=========> Current Page ${_videoReelsController.currentPage}");
                    debugPrint(
                        "=========> Page ${_videoReelsController.page}");
                    debugPrint("=========> Load More Next Page Video");
                  }

                }
              },
              itemBuilder: (context, index) {
                if (_videoReelsController.wishListContentList.length > index) {
                  return OrientationBuilder(
                    builder: (context, orientation) {

                      return Stack(
                        children: [
                          SizedBox(
                              child: WishListTikTokVideoController(
                                contentModel:
                                _videoReelsController.wishListContentList[index].videoId!,
                              )),

                        ],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CustomVideoLoader(),
                  );
                }
              },
            ),
            Positioned(
              top: 44,
              left: 20,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios,
                    size: 18, color: AppColors.white),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
