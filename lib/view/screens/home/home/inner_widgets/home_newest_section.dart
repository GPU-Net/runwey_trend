import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/model/content_model.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/view/screens/video_reels/video_reels_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../../../../model/video_list_model.dart';
import '../../../../widgets/custom_video_widget.dart';
import '../../Controller/home_controller.dart';
import '../../Controller/newest_controller.dart';
import '../../Controller/popular_controller.dart';
import '../../newest/VideoReals/video_reels_screen.dart';

class HomeNewestSection extends StatefulWidget {
  const HomeNewestSection({super.key,});

  @override
  State<HomeNewestSection> createState() => _HomeNewestSectionState();
}

class _HomeNewestSectionState extends State<HomeNewestSection> {

  NewestController newestController= Get.put(NewestController());
  PopularController popularController= Get.put(PopularController());


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 20),
      child: Obx(()=>
         Row(
          crossAxisAlignment: CrossAxisAlignment.start,

            children: List.generate(
                newestController.newestContentList.length,
                    (index) => CustomVideoCard(videoListModel:newestController.newestContentList[index],ontap:(){
                      Get.to(NewestVideoReelsScreen(initIndex: index,));
                    },)
            )
         ),
      ),
    );
  }
}
