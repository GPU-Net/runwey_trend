import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:runwey_trend/helper/helper.dart';
import 'package:runwey_trend/model/content_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../video_reels/widget/url_video_widget.dart';
import '../../Controller/controller_add_video.dart';

class ShowMyVideoTopSection extends StatefulWidget {
  const ShowMyVideoTopSection({super.key,required this.contentModel});
final ContentModel contentModel;
  @override
  State<ShowMyVideoTopSection> createState() => _ShowMyVideoTopSectionState();
}

class _ShowMyVideoTopSectionState extends State<ShowMyVideoTopSection> {
  final _addVideoController = Get.put(AddVideoController());
  @override
  void initState() {
    super.initState();
    DeviceUtils.screenUtils();


  }
  late ContentModel contentData;


  @override
  Widget build(BuildContext context) {
    contentData=widget.contentModel;
    debugPrint("======> tiktok link : ${contentData.tiktok}");
    debugPrint("======> instragram link : ${contentData.instragram}");
    return Column(
      children: [
        UrlVideoView(url:widget.contentModel.videoPath??"",thumbnail: widget.contentModel.thumbnailPath??"",),
        // Stack(
        //   children: [
        //     ClipRRect(
        //       borderRadius: const BorderRadius.all(Radius.circular(8)),
        //       child: AspectRatio(
        //         aspectRatio: _controller.value.aspectRatio,
        //         child: VideoPlayer(_controller),
        //       ),
        //     ),
        //     Positioned(
        //         top: 60,
        //         left: 130,
        //         child: IconButton(
        //             onPressed: () {
        //               setState(() {
        //                 _controller.value.isPlaying
        //                     ? _controller.pause()
        //                     : _controller.play();
        //               });
        //             },
        //             icon: Icon(
        //               size: 50,
        //               _controller.value.isPlaying
        //                   ? Icons.pause_circle_filled
        //                   : Icons.play_circle,
        //               color: Colors.white,
        //             ))
        //     )
        //   ],
        // ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   CustomText(
                    text:widget.contentModel.title??"",
                    color: AppColors.black_100,
                    bottom: 4,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  LikeButton(
                    isLiked: widget.contentModel.isLiked,
                    circleColor: const CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: AppColors.purple,
                      dotSecondaryColor: Colors.white,
                    ),
                    onTap:(bool value)async{
                      bool isLike = await _addVideoController.onLikeButtonTapped(value,widget.contentModel.id!);

                      print("========> This screen ${contentData.likes}");
                      setState(() {
                        contentData.likes+1;
                      });

                      return isLike;
                    },
                    likeBuilder: (bool isLiked) {
                      return isLiked ? const CustomImage(
                        imageType: ImageType.svg,
                        imageColor: AppColors.purple,
                        imageSrc: AppIcons.heart,
                      ) :  const CustomImage(
                          imageType: ImageType.svg,
                          imageColor: AppColors.black_100,
                          imageSrc: AppIcons.heart1);
                    },
                  )
                ],
              ),
              RatingBar.builder(
                itemPadding: const EdgeInsets.only(right: 4),
                itemSize: 14,
                initialRating:widget.contentModel.ratings!,
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
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CustomImage(
                          imageSrc: AppIcons.heart,
                          size: 12,
                          imageColor: AppColors.black_100,
                        ),
                           CustomText(
                            text:Helper.formatLikeAndViewCount(widget.contentModel.likes??0),
                            color: AppColors.black_60,
                            fontSize: 12,
                            left: 4,
                          ),

                      ],
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Row(
                      children: [
                        const CustomImage(
                          imageSrc: AppIcons.eye,
                          size: 12,
                          imageColor: AppColors.black_100,
                        ),
                        CustomText(
                          text:Helper.formatLikeAndViewCount(contentData.popularity) ,
                          color: AppColors.black_60,
                          fontSize: 12,
                          left: 4,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),

             Row(
              children: [
                if( widget.contentModel.tiktok !=null && widget.contentModel.instragram !="")
                InkWell(
                  onTap: (){
                    Helper.launchInstagramProfile(widget.contentModel.instragram??"");
                  },
                  child: const CustomImage(
                      size: 24,
                      imageType: ImageType.svg,
                      imageSrc: AppIcons.skillIconsInstagram),
                ),
                if(widget.contentModel.tiktok !=null&& widget.contentModel.tiktok !="")
                const SizedBox(width: 16),
                if(widget.contentModel.tiktok !=null && widget.contentModel.tiktok !="")
                InkWell(
                  onTap: (){
                    Helper.launchTikTokProfile(widget.contentModel.tiktok??"");
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
        const Divider(
          height: 1,
          color: AppColors.black_40,
        ),
      ],
    );
  }
}
