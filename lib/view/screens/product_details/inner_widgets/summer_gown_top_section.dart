import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/helper.dart';
import 'package:runwey_trend/model/content_details_model.dart';
import 'package:runwey_trend/model/content_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/category_by_content/Controller/category_by_content_controller.dart';
import 'package:runwey_trend/view/screens/home/Controller/newest_controller.dart';
import 'package:runwey_trend/view/screens/home/Controller/popular_controller.dart';
import 'package:runwey_trend/view/screens/store_all_videos/store_all_videos_screen.dart';
import 'package:runwey_trend/view/widgets/cache_nerwork_image.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../video_reels/Controller/url_video_controller.dart';
import '../../video_reels/Controller/video_reels_controller.dart';
import '../../video_reels/widget/url_video_widget.dart';
import '../Controller/products_details_controller.dart';


class SummerGownTopSection extends StatefulWidget {
  const SummerGownTopSection({super.key,required this.screenType});
final String screenType;
  @override
  State<SummerGownTopSection> createState() => _SummerGownTopSectionState();
}

class _SummerGownTopSectionState extends State<SummerGownTopSection> {
  final _controller =Get.put(VideoReelsController());
  final _controllerNewest =Get.put(NewestController());
  final _controllerPopular =Get.put(PopularController());
  final _controllerCategoryByContent =Get.put(CategoryByContentController());
  final _detailsController =Get.put(ContentDetailsController());
  final _videoWidgetController = Get.put(UrlVideoWidgetController());
  @override
  void initState() {
    super.initState();
    DeviceUtils.screenUtils();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UrlVideoView(url:_detailsController.contentDetailsModel.value.attributes!.video!.videoPath??"",thumbnail:_detailsController.contentDetailsModel.value.attributes!.video!.thumbnailPath!),
        Container(
          margin: const EdgeInsets.only(top:16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   CustomText(
                    text: _detailsController.contentDetailsModel.value.attributes!.video!.title??"",
                    color: AppColors.black_100,
                    bottom: 4,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  Obx(()=>
                     LikeButton(
                      isLiked: _detailsController.contentDetailsModel.value.attributes!.video!.isLiked,
                      circleColor:
                      const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor:  const BubblesColor(
                        dotPrimaryColor: AppColors.purple,
                        dotSecondaryColor: Colors.white,
                      ),
                      onTap:(bool value)async{
                       if(widget.screenType==ProductScreenType.newest.name){
                         bool isLike = await _controllerNewest.onLikeButtonTapped(value,_detailsController.contentDetailsModel.value.attributes!.video!.id!);
                         _detailsController.contentDetailsModel.value.attributes!.video!.isLiked!=isLike;
                         _detailsController.getProductsDetails(_detailsController.contentDetailsModel.value.attributes!.video!.id!, false);
                         debugPrint("Details response isLike : $isLike");
                         if(isLike){
                           _detailsController.contentDetailsModel.value.attributes!.video!.likes!=_detailsController.contentDetailsModel.value.attributes!.video!.likes!+1;
                         }else{
                           _detailsController.contentDetailsModel.value.attributes!.video!.likes!=_detailsController.contentDetailsModel.value.attributes!.video!.likes!-1;

                         }
                         return isLike;
                       }else if(widget.screenType==ProductScreenType.popular.name){
                         bool isLike = await _controllerPopular.onLikeButtonTapped(value,_detailsController.contentDetailsModel.value.attributes!.video!.id!);
                         _detailsController.contentDetailsModel.value.attributes!.video!.isLiked!=isLike;
                         _detailsController.getProductsDetails(_detailsController.contentDetailsModel.value.attributes!.video!.id!, false);
                         debugPrint("Details response isLike : $isLike");
                         if(isLike){
                           _detailsController.contentDetailsModel.value.attributes!.video!.likes!=_detailsController.contentDetailsModel.value.attributes!.video!.likes!+1;
                         }else{
                           _detailsController.contentDetailsModel.value.attributes!.video!.likes!=_detailsController.contentDetailsModel.value.attributes!.video!.likes!-1;

                         }
                         return isLike;

                       }else if(widget.screenType==ProductScreenType.category.name){
                         bool isLike = await _controllerCategoryByContent.onLikeButtonTapped(value,_detailsController.contentDetailsModel.value.attributes!.video!.id!);
                         _detailsController.contentDetailsModel.value.attributes!.video!.isLiked!=isLike;
                         _detailsController.getProductsDetails(_detailsController.contentDetailsModel.value.attributes!.video!.id!, false);
                         debugPrint("Details response isLike : $isLike");
                         if(isLike){
                           _detailsController.contentDetailsModel.value.attributes!.video!.likes!=_detailsController.contentDetailsModel.value.attributes!.video!.likes!+1;
                         }else{
                           _detailsController.contentDetailsModel.value.attributes!.video!.likes!=_detailsController.contentDetailsModel.value.attributes!.video!.likes!-1;

                         }
                         return isLike;
                       }else{
                         bool isLike = await _controller.onLikeButtonTapped(value,_detailsController.contentDetailsModel.value.attributes!.video!.id!);
                         _detailsController.contentDetailsModel.value.attributes!.video!.isLiked!=isLike;
                         _detailsController.getProductsDetails(_detailsController.contentDetailsModel.value.attributes!.video!.id!, false);
                         debugPrint("Details response isLike : $isLike");
                         if(isLike){
                           _detailsController.contentDetailsModel.value.attributes!.video!.likes!=_detailsController.contentDetailsModel.value.attributes!.video!.likes!+1;
                         }else{
                           _detailsController.contentDetailsModel.value.attributes!.video!.likes!=_detailsController.contentDetailsModel.value.attributes!.video!.likes!-1;

                         }
                         return isLike;
                       }
                      },
                      likeBuilder: (bool isLiked) {
                        return isLiked ? const CustomImage(
                          imageType: ImageType.svg,
                          imageColor: AppColors.purple,
                          imageSrc: AppIcons.heart,
                        ) : const CustomImage(
                            imageType: ImageType.svg,
                            imageColor: AppColors.black_100,
                            imageSrc: AppIcons.heart1);
                      },
                    ),
                  )
                ],
              ),
              RatingBar.builder(
                itemPadding: const EdgeInsets.only(right: 4),
                itemSize: 14,
                initialRating:_detailsController.contentDetailsModel.value.attributes!.video!.ratings!,
                minRating: 2,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(height: 8,),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomImage(imageSrc: AppIcons.heart,size: 12,imageColor: AppColors.black_100,),
                      Obx(()=>
                         CustomText(
                          text:Helper.formatLikeAndViewCount(_detailsController.contentDetailsModel.value.attributes!.video!.likes??0),
                          color: AppColors.black_60,
                          fontSize: 12,
                          left: 4,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 16,),
                  Row(
                    children: [
                      const CustomImage(imageSrc: AppIcons.eye,size: 12,imageColor: AppColors.black_100,),
                      CustomText(
                        text:Helper.formatLikeAndViewCount(_detailsController.contentDetailsModel.value.attributes!.video!.popularity??0),
                        color: AppColors.black_60,
                        fontSize: 12,
                        left: 4,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  _videoWidgetController.videoPlayerController.pause();
                  _videoWidgetController.chewieController.pause();
                   Get.to(StoreAllVideoScreen(userId:_detailsController.contentDetailsModel.value.attributes!.video!.userId!,));
                },
                child: Row(
                  children: [
                    CustomNetworkImage(imageUrl:_detailsController.contentDetailsModel.value.attributes!.video!.userId!.image!.publicFileUrl!, height:40.w, width: 40.w,boxShape: BoxShape.circle,border: Border.all(color:AppColors.purple,width:1),),
                    // CustomImage(
                    //     size: 40,
                    //     imageType: ImageType.png,
                    //     imageSrc: AppImages.profile2),
                    Flexible(
                      child: CustomText(
                        left: 10,
                        text: _detailsController.contentDetailsModel.value.attributes!.video!.userId!.fullName??"",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
            ),
             Row(

              children: [
                if(_detailsController.contentDetailsModel.value.attributes!.video!.instragram.isNotEmpty)

                  InkWell(
                  onTap: (){
                Helper.launchInstagramProfile(_detailsController.contentDetailsModel.value.attributes!.video!.instragram);
                  },
                  child: const CustomImage(
                      size: 24,
                      imageType: ImageType.svg,
                      imageSrc: AppIcons.skillIconsInstagram),
                ),
                if(_detailsController.contentDetailsModel.value.attributes!.video!.tiktok.isNotEmpty)
                const SizedBox(width: 16),
                if(_detailsController.contentDetailsModel.value.attributes!.video!.tiktok.isNotEmpty)
                InkWell(
                  onTap: (){
                    Helper.launchTikTokProfile(_detailsController.contentDetailsModel.value.attributes!.video!.tiktok);
                  },
                  child: const CustomImage(
                      size: 24,
                      imageType: ImageType.svg,
                      imageSrc: AppIcons.logosTiktokIcon),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        const Divider(height: 1,color: AppColors.black_40,),
      ],
    );
  }
}
