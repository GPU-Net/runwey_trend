import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/model/content_details_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/product_details/Controller/products_details_controller.dart';
import 'package:runwey_trend/view/screens/product_details/inner_widgets/alert_dialogue.dart';
import 'package:runwey_trend/view/screens/video_reels/video_reels_screen.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/similar_video_card.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../SimilarVideoContent/Controller/video_reels_controller.dart';
import '../../../SimilarVideoContent/video_reels_screen.dart';
import '../../video_reels/Controller/url_video_controller.dart';

class SimilarBottomSection extends StatefulWidget {
  const SimilarBottomSection({super.key,required this.contentDetailsModel});
final ContentDetailsModel contentDetailsModel;
  @override
  State<SimilarBottomSection> createState() => _SimilarBottomSectionState();
}

class _SimilarBottomSectionState extends State<SimilarBottomSection> {

  final _contentDetailsController = Get.put(ContentDetailsController());
  final _videoWidgetController = Get.put(WishListUrlVideoWidgetController());
  final SimilarVideoReelsController _similarVideoReelsController=Get.put(SimilarVideoReelsController());



  @override
  void initState() {
    super.initState();
    DeviceUtils.screenUtils();
  }


  @override
  Widget build(BuildContext context) {
    return Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(_similarVideoReelsController.contentList.isNotEmpty)
        const CustomText(
          top: 24,
          text:AppStrings.similar,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          bottom: 16,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(_similarVideoReelsController.contentList.length,
                      (index) => SimilarVideoCard(videoListModel:_similarVideoReelsController.contentList[index],ontap:(){

                    if(_videoWidgetController.videoPlayerController.value.isInitialized){
                      _videoWidgetController.videoPlayerController.pause();
                      _videoWidgetController.chewieController.pause();
                    }
                        Get.to(SimilarVideoReelsScreen(contentId: _similarVideoReelsController.contentList[index].id??"",initIndex: index,));
                      },))),
        ),
        const SizedBox(height: 24,),
        // Row(
        //   children: [
        //     Expanded(
        //       flex: 0,
        //       child: CustomButton(
        //         rightPadding: 26,
        //         leftPadding: 26,
        //         topPadding: 12,
        //         bottomPadding: 12,
        //         buttonBgColor: AppColors.white,
        //         onPressed: () {
        //           showDialog<void>(
        //             context: context,
        //             barrierDismissible: true, // user must tap button!
        //             builder: (BuildContext context) {
        //               return const AlertDialogBoxe();
        //             },
        //           );
        //         },
        //         titleText: AppStrings.rateUs,
        //         titleColor: AppColors.purple,
        //         buttonBorderColor: AppColors.purple,
        //         borderWidth: 1,
        //         titleSize: 16,
        //         titleWeight: FontWeight.w600,
        //       ),
        //     ),
        //     const SizedBox(width: 16,),
        //     // Expanded(
        //     //   flex: 1,
        //     //   child: Obx(()=> NewCustomButton(onTap:(){
        //     //     _contentDetailsController.addWishList(widget.contentDetailsModel.attributes!.video!.id??"");
        //     //   },text:AppStrings.addToWishlist,loading:_contentDetailsController.wishListAddLoading.value,)),
        //     //   // child: CustomButton(
        //     //   //   rightPadding: 26,
        //     //   //   leftPadding: 26,
        //     //   //   topPadding: 12,
        //     //   //   bottomPadding: 12,
        //     //   //   buttonBgColor: AppColors.purple,
        //     //   //   onPressed: () {
        //     //   //     Get.toNamed(AppRoute.myWishlistScreen);
        //     //   //   },
        //     //   //   titleText: AppStrings.addToWishlist,
        //     //   //   titleColor: AppColors.white,
        //     //   //   buttonBorderColor: AppColors.purple,
        //     //   //   borderWidth: 1,
        //     //   //   titleSize: 16,
        //     //   //   titleWeight: FontWeight.w600,
        //     //   // ),
        //     // ),
        //   ],
        // ),
      ],
    );
  }
}