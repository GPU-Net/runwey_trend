import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../../../model/content_model.dart';
import '../../../widgets/custom_circle_loading.dart';
import '../../../widgets/custom_content_widget.dart';
import '../Controller/store_controller.dart';
import '../StoreVideoContent/video_reels_screen.dart';

class AllVideoSection extends StatefulWidget {
  const AllVideoSection({super.key,required this.userId});
final String userId;

  @override
  State<AllVideoSection> createState() => _AllVideoSectionState();
}

class _AllVideoSectionState extends State<AllVideoSection> {
  final _controller = Get.put(StoreAllVideoController());
  @override
  void initState() {
    super.initState();
    DeviceUtils.screenUtils();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MasonryGridView.builder(
          shrinkWrap: true,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
          itemCount: _controller.allStoreContentList.length,
          gridDelegate:const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
          itemBuilder: (context, index) {
            var data = _controller.allStoreContentList[index];
            return CustomContentCard(videoListModel:data,ontap:(){
              Get.to(() =>  StoreVideoReelsScreen(userId: widget.userId, initIndex: index,));
            },);
          },
        ),
        if(_controller.isLoadMoreRunning.value)
          const SizedBox(height: 10,),
        if(_controller.isLoadMoreRunning.value)
          const CustomCircleLoader(),
        if(_controller.isLoadMoreRunning.value)
          const SizedBox(height: 20,),

      ],
    );
  }
}