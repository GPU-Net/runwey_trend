
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:runwey_trend/helper/helper.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/view/screens/home/Controller/newest_controller.dart';
import 'package:runwey_trend/view/screens/video_reels/Controller/video_controller.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/route/app_route.dart';
import '../../../../../model/content_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../widgets/cache_nerwork_image.dart';
import '../../../widgets/custom_video_loader.dart';
import '../../../widgets/image/custom_image.dart';
import '../../../widgets/text/custom_text.dart';
import '../Controller/category_by_content_controller.dart';




class CategoryByTikTokVideoController extends StatefulWidget {
  const CategoryByTikTokVideoController({super.key, required this.contentModel});
  final ContentModel contentModel;

  @override
  State<CategoryByTikTokVideoController> createState() => _CategoryByTikTokVideoControllerState();
}

class _CategoryByTikTokVideoControllerState extends State<CategoryByTikTokVideoController> {
   late VideoPlayerController videoPlayerController;
  late bool isVideoInitialized=false;
  late bool isPlaying;
final _controller =Get.put(CategoryByContentController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){

      debugPrint("======-----------> $isVideoInitialized video player controller dispose");
      isVideoInitialized = false;
      isPlaying = true;
      // Initial state, you can set it to false if you want to start with the video paused.
      initializeVideo();

      // Add Your Code here.

    });

  }

  Future<void> initializeVideo() async {
    final uri1= Uri.parse(widget.contentModel.videoPath!);
    final uri2=uri1.replace(scheme:"https");
    debugPrint("====> $uri1");
    debugPrint("====> $uri2");

    videoPlayerController =
        VideoPlayerController.networkUrl(uri1);

    await videoPlayerController.initialize();
    setState(() {
      isVideoInitialized = true;
    });

    if (isPlaying) {
      videoPlayerController.play();
    }
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
   // isVideoInitialized = false;
    debugPrint("video player controller dispose");
    super.dispose();
  }
  @override
  void deactivate() {
    // Pauses video when navigating away
    debugPrint("video player controller deactivate");
    videoPlayerController.pause();

    super.deactivate();
  }



  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        videoPlayerController.play();
      } else {
        videoPlayerController.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Colors.black),
          child: isVideoInitialized
              ? GestureDetector(
            onTap: togglePlayPause,
            child: AspectRatio(aspectRatio:videoPlayerController.value.aspectRatio,
            child: VideoPlayer(videoPlayerController)),
          )
              : const Center(
            child: CustomVideoLoader(),
          ),
        ),
        if (isVideoInitialized && !isPlaying)
          Center(
            child: IconButton(
              icon: const CustomImage(imageSrc: AppIcons.play,) ,
              onPressed: togglePlayPause,
              color: Colors.white,
            ),
          ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.contentModel.title??"",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(height: 12),
              RatingBar.builder(
                itemSize: 20,
                initialRating: widget.contentModel.ratings!,
                minRating: 1,
                itemPadding: const EdgeInsets.only(right: 4),
                direction: Axis.horizontal,
                allowHalfRating:true,
                ignoreGestures: true,
                itemCount: 5,
                unratedColor: Colors.grey.shade700,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            children: [
              CustomNetworkImage(
                imageUrl: widget.contentModel.userId!.image!.publicFileUrl!,
                height:50 ,
                width: 50,
                boxShape: BoxShape.circle,
                backgroundColor: AppColors.purple_20,
              ),
              // Container(
              //   padding:const EdgeInsets.all(8),
              //   decoration: const BoxDecoration(
              //       color: AppColors.purple_20,
              //       shape: BoxShape.circle
              //   ),
              //
              //   child: const CustomImage(imageSrc: AppImages.amrin,imageType: ImageType.png,size: 24,),
              // ),
              CustomText(
                text:Helper.formatLikeAndViewCount(widget.contentModel.likes),
                color: AppColors.white,
                top: 16,
                bottom: 12,
              ),
              LikeButton(
                circleColor:
                const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                bubblesColor:  const BubblesColor(
                  dotPrimaryColor: AppColors.purple,
                  dotSecondaryColor: Colors.white,
                ),
               isLiked:widget.contentModel.isLiked,
               onTap:(bool value)async{
                  bool isLike = await _controller.onLikeButtonTapped(value,widget.contentModel.id!);
                  return isLike;
               },
                likeBuilder: (bool isLiked) {
                  return isLiked ? const CustomImage(
                    imageType: ImageType.svg,
                    imageColor: AppColors.purple,
                    imageSrc: AppIcons.heart,
                  ) : const CustomImage(
                      imageType: ImageType.svg,
                      imageColor: AppColors.white,
                      imageSrc: AppIcons.heart1);
                },
              ) ,
              CustomText(
                text: Helper.formatLikeAndViewCount(widget.contentModel.popularity),
                color: AppColors.white,
                top: 16,
                bottom: 12,
              ),
              const CustomImage(imageSrc: AppIcons.eyeOn,imageColor: AppColors.white,size: 24,),
              const SizedBox(height: 12,),
              GestureDetector(
                  onTap: (){
                    videoPlayerController.pause();
                    isPlaying=false;
                    setState(() {

                    });
                    Get.toNamed(AppRoute.productDetailsScreen,parameters:{"contentId":widget.contentModel.id!,"screenType":ProductScreenType.category.name});
                  },
                  child: const Icon(Icons.info_outline,size: 24,color: AppColors.white,))
            ],
          ),
        ),
      ],
    );
  }
}
