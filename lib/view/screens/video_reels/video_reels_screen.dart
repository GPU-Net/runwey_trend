import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/AdMob/ad_display.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/view/screens/video_reels/Controller/video_reels_controller.dart';
import 'package:runwey_trend/view/screens/video_reels/tiktok_video_controller.dart';
import 'package:runwey_trend/view/screens/video_reels/video_player.dart';
import 'package:runwey_trend/view/widgets/cache_nerwork_image.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/custom_video_loader.dart';

class VideoReelsScreen extends StatefulWidget {
  const VideoReelsScreen({Key? key,required this.contentId}) : super(key: key);


  final String contentId;
  @override
  State<VideoReelsScreen> createState() => _VideoReelsScreenState();
}

class _VideoReelsScreenState extends State<VideoReelsScreen> {




  late PageController pageController;

  final _videoReelsController=Get.put(VideoReelsController());
  var _currentPage=0;


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        pageController = PageController();
        _videoReelsController.getVideoList(widget.contentId);
      });
    });

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
      child: Obx(()=>_videoReelsController.loading.value?
            Scaffold(
             backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: const Center(
                child: CustomVideoLoader(),
              ),
            ):
            Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: pageController,

                    itemCount: _videoReelsController.contentList.length,
                    onPageChanged: (int page) {
                      debugPrint("=========> Page Number : $page");
                      _videoReelsController.handleView(_videoReelsController.contentList[page].id!);
                    //  _videoReelsController.handleView("657c13d2c7bef712cd981dfa");
                      if (page == _videoReelsController.contentList.length - 1) {
                        _videoReelsController.loadMoreGetVideoList(widget.contentId);
                        debugPrint("=========> Current Page ${_videoReelsController.currentPage}");
                        debugPrint("=========> Page ${_videoReelsController.page}");
                        debugPrint("=========> Load More Next Page Video");
                      }
                    },
                    itemBuilder: (context, index) {
                      var data =_videoReelsController.contentList[index];
                      return OrientationBuilder(
                        builder: (context, orientation) {
                          // if (orientation == Orientation.portrait) {
                          //   SystemChrome.setPreferredOrientations([
                          //     DeviceOrientation.portraitUp,
                          //     DeviceOrientation.portraitDown,
                          //   ]);
                          // } else {
                          //   SystemChrome.setPreferredOrientations([
                          //     DeviceOrientation.landscapeRight,
                          //     DeviceOrientation.landscapeLeft,
                          //   ]);
                          // }
                          return Stack(
                            children: [
                              SizedBox(
                                  child:TikTokVideoController (contentModel:_videoReelsController.contentList[index],)
                              ),
                              // Positioned(
                              //   bottom: 20,
                              //   left: 20,
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         _videoReelsController.contentList[index].title??"",
                              //         style: GoogleFonts.montserrat(
                              //           color: Colors.white,
                              //           fontSize: 22,
                              //           fontWeight: FontWeight.w600,
                              //           height: 0,
                              //         ),
                              //       ),
                              //       const SizedBox(height: 12),
                              //       RatingBar.builder(
                              //         itemSize: 20,
                              //         initialRating: _videoReelsController.contentList[index].ratings!.toDouble(),
                              //         minRating: 1,
                              //         itemPadding: const EdgeInsets.only(right: 4),
                              //         direction: Axis.horizontal,
                              //         allowHalfRating: false,
                              //         ignoreGestures: true,
                              //         itemCount: 5,
                              //         unratedColor: Colors.grey.shade700,
                              //         itemBuilder: (context, _) => const Icon(
                              //           Icons.star,
                              //           color: Colors.amber,
                              //         ),
                              //         onRatingUpdate: (rating) {},
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              //
                              // Positioned(
                              //   bottom: 20,
                              //   right: 20,
                              //   child: Column(
                              //     children: [
                              //       CustomNetworkImage(
                              //           imageUrl:  _videoReelsController.contentList[index].userId!.image!.publicFileUrl!,
                              //           height:50 ,
                              //           width: 50,
                              //           boxShape: BoxShape.circle,
                              //         backgroundColor: AppColors.purple_20,
                              //       ),
                              //       // Container(
                              //       //   padding:const EdgeInsets.all(8),
                              //       //   decoration: const BoxDecoration(
                              //       //       color: AppColors.purple_20,
                              //       //       shape: BoxShape.circle
                              //       //   ),
                              //       //
                              //       //   child: const CustomImage(imageSrc: AppImages.amrin,imageType: ImageType.png,size: 24,),
                              //       // ),
                              //        CustomText(
                              //         text: _videoReelsController.contentList[index].likes.toString(),
                              //         color: AppColors.white,
                              //         top: 16,
                              //         bottom: 12,
                              //       ),
                              //       LikeButton(
                              //         circleColor:
                              //         const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                              //         bubblesColor:  const BubblesColor(
                              //           dotPrimaryColor: AppColors.purple,
                              //           dotSecondaryColor: Colors.white,
                              //         ),
                              //         onTap: _videoReelsController.onLikeButtonTapped,
                              //         likeBuilder: (bool isLiked) {
                              //           return isLiked ? const CustomImage(
                              //             imageType: ImageType.svg,
                              //             imageColor: AppColors.purple,
                              //             imageSrc: AppIcons.heart,
                              //           ) : const CustomImage(
                              //               imageType: ImageType.svg,
                              //               imageColor: AppColors.white,
                              //               imageSrc: AppIcons.heart1);
                              //         },
                              //       ) ,
                              //        CustomText(
                              //         text:  _videoReelsController.contentList[index].view.toString(),
                              //         color: AppColors.white,
                              //         top: 16,
                              //         bottom: 12,
                              //       ),
                              //       const CustomImage(imageSrc: AppIcons.eyeOn,imageColor: AppColors.white,size: 24,),
                              //       const SizedBox(height: 12,),
                              //       GestureDetector(
                              //           onTap: (){
                              //             Get.toNamed(AppRoute.productDetailsScreen,arguments:_videoReelsController.contentList[index].id);
                              //           },
                              //           child: const Icon(Icons.info_outline,size: 24,color: AppColors.white,))
                              //     ],
                              //   ),
                              // ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Positioned(
                    top: 44, left: 20,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back_ios, size: 18, color: AppColors.white),
                    ),
                  ),
                ],
              ),
            )

      ),
    );
  }
}
