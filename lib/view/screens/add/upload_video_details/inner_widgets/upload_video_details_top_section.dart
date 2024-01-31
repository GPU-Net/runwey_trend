import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/container/custom_container_card.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

class UploadVideoDetailsTopSection extends StatefulWidget {
  const UploadVideoDetailsTopSection({super.key});

  @override
  State<UploadVideoDetailsTopSection> createState() => _UploadVideoDetailsTopSectionState();
}

class _UploadVideoDetailsTopSectionState extends State<UploadVideoDetailsTopSection> {
  int selectorCategory = 0;
  List<Map<String,dynamic>> categoryList = [
    {
      "categoryIcon" : AppIcons.videoCamera,
      "category" : AppStrings.record,
    },
    {
      "categoryIcon" : AppIcons.photograph,
      "category" : AppStrings.gallery,
    },
  ];

  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    DeviceUtils.screenUtils();

    _controller = VideoPlayerController.asset(
        'assets/video/istockphoto-1296393481-640_adpp_is.mp4') ..initialize().then((_) {
      setState(() {});
    });
  }
  // File? video;
  // VideoPlayerController? videocontroller;
  // Future<void> pickvideofromgallery() async {
  //   final videopicked =
  //   await ImagePicker().pickVideo(source: ImageSource.gallery);
  //   if (videopicked != null) {
  //     video = File(videopicked.path);
  //     videocontroller = VideoPlayerController.file(video!)
  //       ..initialize().then((_) {
  //         setState(() {});
  //         videocontroller!.play();
  //         videocontroller!.setLooping(true);
  //       });
  //   }
  // }
  File? pickedVideo;

  Future<void> pickVideoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ["mp4"],
        type: FileType.custom);

    if (result != null && result.files.isNotEmpty) {
        pickedVideo = File(result.files.single.path!);
     var  carREPUVEFillName = result.files.single.name;

        // addCarDocumentsFiles =[];
        // addCarDocumentsFiles.add(pickedVideo!);
        _controller = VideoPlayerController.file(
           File(pickedVideo!.path)) ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Stack(
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(8)),
              child: SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller) ,
                ),
              ),
            ),
            Positioned(
                top: 70,
                left: 150,
                child:GestureDetector(
                  onTap: (){
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child:_controller.value.isPlaying ? const Icon(Icons.pause_circle_filled,size: 50,color: AppColors.white,) : const CustomImage(imageSrc: AppIcons.play,size: 50,) ,)
            )
          ],
        ),
        const CustomText(
          text: AppStrings.chooseOptionForReUpload,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.black_100,
          top: 24,
          bottom: 16,
        ),
        Row(
            children:List.generate(categoryList.length, (index) {
              return Flexible(
                child: GestureDetector(
                  onTap: (){
                    if(index==1){
                      pickVideoFile();
                    }
                    setState(() {
                      selectorCategory=index;
                    });
                  },
                  child: CustomContainerCard(
                      paddingRight: 54,
                      paddingLeft: 54,
                      paddingBottom: 22,
                      paddingTop: 22,
                      marginRight: 8,
                      marginLeft: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color:AppColors.purple_40,width: 1),
                        color: selectorCategory == index ? AppColors.purple:AppColors.white,

                      ),
                      content:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImage(imageSrc: categoryList[index]["categoryIcon"],imageColor: selectorCategory == index ? AppColors.white:AppColors.purple,),
                          CustomText(text:categoryList[index]["category"],
                            color: selectorCategory == index ? AppColors.white:AppColors.purple,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            top: 10,
                          )
                        ],
                      )
                  ),
                ),
              );
            })
        ),
      ],
    );
  }
}
