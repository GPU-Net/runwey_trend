import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/date_formate_helper.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/view/screens/add/Controller/controller_add_video.dart';
import 'package:runwey_trend/view/screens/add/show_my_video/show_my_video_screen.dart';
import 'package:runwey_trend/view/widgets/custom_circle_loading.dart';
import 'package:runwey_trend/view/widgets/custom_video_widget.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../../../../helper/helper.dart';

class AddUploadVideoSection extends StatefulWidget {
  const AddUploadVideoSection({super.key});

  @override
  State<AddUploadVideoSection> createState() => _AddUploadVideoSectionState();
}

class _AddUploadVideoSectionState extends State<AddUploadVideoSection> {
 final _addVideoController =Get.put(AddVideoController());

  @override
  void initState() {
    _addVideoController.scrollController = ScrollController();
    _addVideoController.scrollController.addListener(() {
      if (_addVideoController.scrollController.position.pixels ==
          _addVideoController.scrollController.position.maxScrollExtent) {
        _addVideoController.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _addVideoController.scrollController,
      child: Obx(()=> _addVideoController.searchLoading.value?const CustomCircleLoader():_addVideoController.allMyContentList.isEmpty?const Center(child: Text("No data found!",style: TextStyle(fontSize: 18,color: Colors.grey),),):
         GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 190
            ),
            itemCount: _addVideoController.allMyContentList.length,
            itemBuilder: (BuildContext context, index){
              // return CustomVideoCard(videoListModel:_addVideoController.allMyContentList[index],ontap: (){
              //   Get.toNamed(AppRoute.showMyVideoScreen);
              // },);
              var data =_addVideoController.allMyContentList[index];
              return  GestureDetector(
                  onTap: (){
                    Get.to(ShowMyVideoScreen(contentModel:_addVideoController.allMyContentList[index]));

                    //Get.toNamed(AppRoute.showMyVideoScreen);
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: const [
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
                        Expanded(
                          flex: 2,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                  imageUrl: _addVideoController.allMyContentList[index].thumbnailPath??"",
                                  imageBuilder: (context, imageProvider) =>
                                      Stack(
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
                                          Positioned(
                                              top: 40,
                                              left: 70,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   _controller.value.isPlaying
                                                    //       ? _controller.pause()
                                                    //       : _controller.play();
                                                    // });
                                                  },
                                                  child:  const CustomImage(
                                                    imageSrc: AppIcons.play,
                                                    size: 34,
                                                  ))),
                                           Positioned(
                                              left: 10,
                                              bottom: 10,
                                              child: Row(
                                                children: [
                                                  const CustomImage(
                                                    imageSrc: AppIcons.clock,
                                                  ),
                                                  CustomText(
                                                    text: Helper.formatDuration(data.duration??0.0),
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
                              // ClipRRect(
                              //   borderRadius: const BorderRadius.only(topRight: Radius.circular(12),topLeft:Radius.circular(12)),
                              //   child: AspectRatio(
                              //     aspectRatio: _controller.value.aspectRatio,
                              //     child: VideoPlayer(_controller),
                              //   ),
                              // ),
                              // Positioned(
                              //     top: 40,
                              //     left: 60,
                              //     child: GestureDetector(
                              //         onTap: (){
                              //           // setState(() {
                              //           //   _controller.value.isPlaying
                              //           //       ? _controller.pause()
                              //           //       : _controller.play();
                              //           // });
                              //         },
                              //         child: CustomImage(imageSrc: AppIcons.play,size: 34,))
                              // ),
                              // const Positioned(
                              //     left: 10,
                              //     bottom: 10,
                              //     child: Row(
                              //       children: [
                              //         CustomImage(imageSrc: AppIcons.clock,),
                              //         CustomText(
                              //           text: '0:10',
                              //           color: AppColors.white,
                              //           fontSize: 12,
                              //           left: 6,
                              //         )
                              //       ],
                              //     ))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 CustomText(
                                  text:data.title??"",
                                  color: AppColors.black_100,
                                  bottom: 4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                RatingBar.builder(
                                  itemSize: 12,
                                  initialRating:data.ratings?.toDouble()??0,
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
                                const SizedBox(height: 8,),
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomImage(imageSrc: AppIcons.heart,size: 12,imageColor: AppColors.black_60,),
                                        CustomText(
                                          text: Helper.formatLikeAndViewCount(data.likes??0),
                                          color: AppColors.black_60,
                                          fontSize: 12,
                                          left: 4,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const CustomImage(imageSrc: AppIcons.eye,size: 12,imageColor: AppColors.black_60,),
                                        CustomText(
                                          text: Helper.formatLikeAndViewCount(data.popularity??0),
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
                        )
                      ],
                    ),
                  )
              );
            }),
      ),
    );
  }
}
