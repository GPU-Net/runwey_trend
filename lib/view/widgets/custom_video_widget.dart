
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:runwey_trend/helper/helper.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../model/content_model.dart';
import '../../model/video_list_model.dart';
import '../../services/api_constant.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../screens/video_reels/video_reels_screen.dart';
import 'image/custom_image.dart';

class CustomVideoCard extends StatelessWidget {
  const CustomVideoCard({
    super.key,
    required this.videoListModel,
    this.ontap

  });
  final ContentModel videoListModel;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:ontap??(){
        Get.to(() =>  VideoReelsScreen(contentId: videoListModel.id??"",));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: videoListModel.thumbnailPath??"",
                imageBuilder: (context, imageProvider) =>
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Positioned(

                            child: CustomImage(
                              imageSrc: AppIcons.play,
                              size: 34,
                            )),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: Row(
                              children: [
                                const CustomImage(
                                  imageSrc: AppIcons.clock,
                                ),
                                CustomText(
                                  text: Helper.formatDuration(videoListModel.duration??0.0),
                                  color: AppColors.white,
                                  fontSize: 12,
                                  left: 6,
                                )
                              ],
                            ))
                      ],
                    ),
                placeholder: (context, url) =>Container(
                  height: 150,
                  decoration:  BoxDecoration(
                      color:Colors.grey.shade200,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
                  ),

                )
                ,
                errorWidget: (context, url, error) =>
                    Container(
                      height: 150,
                      decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                          color:Colors.grey.shade300
                      ),
                      alignment: Alignment.center,
                      child:   const Icon(Icons.error),

                    )



            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: videoListModel.title??"",
                    color: AppColors.black_100,
                    bottom: 4,
                  ),
                  RatingBar.builder(
                    itemSize: 12,
                    initialRating:videoListModel.ratings!,
                    minRating: 1,
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
                  const SizedBox(
                    height: 8,
                  ),
                   Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CustomImage(
                            imageSrc: AppIcons.heart,
                            size: 12,
                            imageColor: AppColors.black_60,
                          ),
                          CustomText(
                            text: Helper.formatLikeAndViewCount(videoListModel.likes??0),
                            color: AppColors.black_60,
                            fontSize: 12,
                            left: 4,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const CustomImage(
                            imageSrc: AppIcons.eye,
                            size: 12,
                            imageColor: AppColors.black_60,
                          ),
                          CustomText(
                            text: Helper.formatLikeAndViewCount(videoListModel.popularity),
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
            )
          ],
        ),
      ),
    );
  }
}


