import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/model/video_list_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/view/screens/video_reels/video_reels_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../../../../model/content_model.dart';
import '../../../../widgets/custom_video_widget.dart';
import '../../Controller/home_controller.dart';
import '../../Controller/newest_controller.dart';
import '../../Controller/popular_controller.dart';
import '../../popular/VideoReals/video_reels_screen.dart';

class HomePopularSection extends StatefulWidget {
  const HomePopularSection({super.key,});

  @override
  State<HomePopularSection> createState() => _HomePopularSectionState();
}

class _HomePopularSectionState extends State<HomePopularSection> {
  NewestController newestController= Get.put(NewestController());
  PopularController popularController= Get.put(PopularController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 20),
      scrollDirection: Axis.horizontal,
      child: Obx(()=>
         Row(
            children: List.generate(
                popularController.popularContentList.length,
                    (index) => CustomVideoCard(videoListModel:popularController.popularContentList[index],ontap:(){
                      Get.to(PopularVideoReelsScreen(initIndex:index,));
                    },))),
      ),
    );
  }
}
