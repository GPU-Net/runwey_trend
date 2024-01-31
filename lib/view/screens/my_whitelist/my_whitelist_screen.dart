import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/screens/my_whitelist/Controller/wish_list_controller.dart';
import 'package:runwey_trend/view/screens/my_whitelist/video_reels/video_reels_screen.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/empty_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/app_constent.dart';
import '../../widgets/buttons/custom_back_button.dart';
import '../../widgets/custom_circle_loading.dart';
import '../../widgets/custom_content_widget.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/general_error_screen.dart';
import '../../widgets/no_internet_screen.dart';

class MyWishlistScreen extends StatefulWidget {
  const MyWishlistScreen({super.key});

  @override
  State<MyWishlistScreen> createState() => _MyWishlistScreenState();
}

class _MyWishlistScreenState extends State<MyWishlistScreen> {
  final _wishListController = Get.put(WishListController());
  @override
  void initState() {
    _wishListController.fastLoad();
    _wishListController.scrollController = ScrollController();
    _wishListController.scrollController.addListener(() {
      if (_wishListController.scrollController.position.pixels ==
          _wishListController.scrollController.position.maxScrollExtent) {
        _wishListController.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(),
              Text(
                AppStrings.myWishlist,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: AppColors.black_100,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
        body: Obx(() {
          switch (_wishListController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();

            case Status.internetError:
              return NoInternetScreen(onTap: () {
                _wishListController.fastLoad();
              });
            case Status.error:
              return GeneralErrorScreen(onTap: () {
                _wishListController.fastLoad();
              });
            case Status.completed:
              return _wishListController.wishListContentList.isEmpty
                  ? const EmptyScreen()
                  : SingleChildScrollView(
                      controller: _wishListController.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          MasonryGridView.builder(
                            shrinkWrap: true,
                            crossAxisSpacing: 8.w,
                            mainAxisSpacing: 8.h,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            itemCount:
                                _wishListController.wishListContentList.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              var data = _wishListController
                                  .wishListContentList[index];
                              return Obx(() => _wishListController
                                      .isSelected.value
                                  ? Stack(
                                      children: [
                                        CustomContentCard(
                                            ontap: () {
                                              _wishListController
                                                  .selectContent(index);
                                              debugPrint("select $index");

                                            },
                                            videoListModel: data.videoId!),
                                        // clicked
                                        Positioned(
                                          right: 8,
                                          top: 8,
                                          child: _wishListController
                                                  .isSelectRemoveList[index]
                                              ? Container(
                                                  height: 20,
                                                  width: 20,
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .all(0.5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.purple,
                                                    border: Border.all(
                                                        color: AppColors.white),
                                                    shape: BoxShape.circle,
                                                  ),
                                                )
                                              : Container(
                                                  height: 20,
                                                  width: 20,
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .all(0.5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            AppColors.purple),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    )
                                  : GestureDetector(
                                      onLongPress: () {
                                        debugPrint("select $index");

                                        _wishListController
                                            .selectContent(index);
                                        _wishListController.isSelected.value =
                                            true;
                                      },
                                      child: CustomContentCard(
                                          videoListModel: data.videoId!,ontap:(){
                                        Get.to(() =>  WishListVideoReelsScreen(initIndex:index,));

                                      },)));
                            },
                          ),
                          if (_wishListController.isLoadMoreRunning.value)
                            const SizedBox(
                              height: 10,
                            ),
                          if (_wishListController.isLoadMoreRunning.value)
                            const CustomCircleLoader(),

                            const SizedBox(
                              height: 100,
                            ),
                        ],
                      ),
                    );
          }
        }),
        bottomNavigationBar: Obx(() => _wishListController.isSelected.value
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: NewCustomButton(
                  onTap: () {
                    _wishListController.removeWishList();
                  },
                  text: "Remove from wishlist",
                  loading: _wishListController.isRemoveLoading.value,
                ))
            : const SizedBox()),
      ),
      // child: Scaffold(
      //   backgroundColor: AppColors.white,
      //   appBar: CustomAppBar(
      //     appBarContent: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         GestureDetector(
      //           onTap: () {
      //             Get.back();
      //           },
      //           child: const Icon(Icons.arrow_back_ios_new_outlined, size: 16, color: AppColors.black_100),
      //         ),
      //         Text(
      //           AppStrings.myWishlist,
      //           textAlign: TextAlign.center,
      //           style: GoogleFonts.montserrat(
      //             color: AppColors.black_100,
      //             fontSize: 18,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //         const SizedBox()
      //       ],
      //     ),
      //   ),
      //   body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      //     return SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           SingleChildScrollView(
      //             padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
      //             child: GridView.builder(
      //               shrinkWrap: true,
      //               physics: const NeverScrollableScrollPhysics(),
      //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 crossAxisSpacing: 8,
      //                 mainAxisSpacing: 8,
      //                 mainAxisExtent: 190,
      //               ),
      //               itemCount: 20,
      //               itemBuilder: (BuildContext context, index) {
      //                 return GestureDetector(
      //                   onLongPress: () {
      //                     changeGender(index);
      //                   },
      //                   child: Container(
      //                     decoration: ShapeDecoration(
      //                       color: AppColors.white,
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(12),
      //                       ),
      //                       shadows: const [
      //                         BoxShadow(
      //                           color: Color(0x14000000),
      //                           blurRadius: 10,
      //                           offset: Offset(0, 0),
      //                           spreadRadius: 0,
      //                         )
      //                       ],
      //                     ),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Expanded(
      //                           flex: 2,
      //                           child: Stack(
      //                             fit: StackFit.expand,
      //                             children: [
      //                               ClipRRect(
      //                                 borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
      //                                 child: AspectRatio(
      //                                   aspectRatio: _controller.value.aspectRatio,
      //                                   child: VideoPlayer(_controller),
      //                                 ),
      //                               ),
      //                               Positioned(
      //                                 top: 40,
      //                                 left: 60,
      //                                 child: GestureDetector(
      //                                     onTap: (){
      //                                       // setState(() {
      //                                       //   _controller.value.isPlaying
      //                                       //       ? _controller.pause()
      //                                       //       : _controller.play();
      //                                       // });
      //                                     },
      //                                     child: const CustomImage(imageSrc: AppIcons.play,size: 34,))
      //                               ),
      //                               // clicked
      //                               Positioned(
      //                                 right: 8,
      //                                 top: 8,
      //                                 child: isSelected[index]
      //                                     ? Container(
      //                                   height: 20,
      //                                   width: 20,
      //                                   padding: const EdgeInsetsDirectional.all(0.5),
      //                                   decoration: BoxDecoration(
      //                                     color: Colors.transparent,
      //                                     border: Border.all(color: AppColors.purple),
      //                                     shape: BoxShape.circle,
      //                                   ),
      //                                   child: GestureDetector(
      //                                     onTap: () {
      //                                     },
      //                                     child: Container(
      //                                       decoration: BoxDecoration(
      //                                         color: isSelected[index] ? AppColors.purple : Colors.transparent,
      //                                         shape: BoxShape.circle,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 )
      //                                     : const SizedBox(),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                         Expanded(
      //                           flex: 0,
      //                           child: Container(
      //                             padding: const EdgeInsets.all(8),
      //                             child: Column(
      //                               crossAxisAlignment: CrossAxisAlignment.start,
      //                               children: [
      //                                 const CustomText(
      //                                   text: 'Summer Gown',
      //                                   color: AppColors.black_100,
      //                                   bottom: 4,
      //                                   fontSize: 14,
      //                                   fontWeight: FontWeight.w400,
      //                                 ),
      //                                 RatingBar.builder(
      //                                   itemSize: 12,
      //                                   initialRating: 5,
      //                                   minRating: 1,
      //                                   direction: Axis.horizontal,
      //                                   allowHalfRating: true,
      //                                   itemCount: 5,
      //                                   itemBuilder: (context, _) => const Icon(
      //                                     Icons.star,
      //                                     color: Colors.amber,
      //                                   ),
      //                                   onRatingUpdate: (rating) {
      //                                     print(rating);
      //                                   },
      //                                 ),
      //                                 const SizedBox(height: 8),
      //                                 const Row(
      //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                   children: [
      //                                     Row(
      //                                       children: [
      //                                         CustomImage(imageSrc: AppIcons.heart, size: 12, imageColor: AppColors.black_60),
      //                                         CustomText(
      //                                           text: '6k',
      //                                           color: AppColors.black_60,
      //                                           fontSize: 12,
      //                                           left: 4,
      //                                         ),
      //                                       ],
      //                                     ),
      //                                     Row(
      //                                       children: [
      //                                         CustomImage(imageSrc: AppIcons.eye, size: 12, imageColor: AppColors.black_60),
      //                                         CustomText(
      //                                           text: '10.8k',
      //                                           color: AppColors.black_60,
      //                                           fontSize: 12,
      //                                           left: 4,
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   }),
      // ),
    );
  }
}
