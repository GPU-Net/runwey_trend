import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/view/screens/home/Controller/popular_controller.dart';
import 'package:runwey_trend/view/widgets/custom_circle_loading.dart';
import 'package:runwey_trend/view/widgets/custom_content_widget.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';

import '../../Controller/newest_controller.dart';
import '../VideoReals/video_reels_screen.dart';

class PopularProductSection extends StatefulWidget {
  const PopularProductSection({super.key});
  @override
  State<PopularProductSection> createState() => _PopularProductSectionState();
}

class _PopularProductSectionState extends State<PopularProductSection> {
  final _controller = Get.put(PopularController());
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        _controller.refreshLoad();
      },
      child: Obx((){

        return SingleChildScrollView(
          controller: _controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              MasonryGridView.builder(
                shrinkWrap: true,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                itemCount: _controller.popularContentList.length,
                gridDelegate:const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
                itemBuilder: (context, index) {

                  var data = _controller.popularContentList[index];
                  return CustomContentCard(videoListModel:data,ontap:(){
                    Get.to(PopularVideoReelsScreen(initIndex:index,));
                  },);

                },
              ),
              if(_controller.isLoadMoreRunning.value)
                const SizedBox(height: 10,),
              if(_controller.isLoadMoreRunning.value)
                const CustomCircleLoader(),
                const SizedBox(height: 120,),

            ],
          ),
        );

      }

      ),
    );
  }
}
