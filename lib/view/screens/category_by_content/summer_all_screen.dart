import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/category_by_content/Controller/category_by_content_controller.dart';
import 'package:runwey_trend/view/screens/category_by_content/search_end_drawer.dart';

import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_search_field.dart';
import 'package:video_player/video_player.dart';

import '../../../helper/prefs_helper.dart';
import '../../widgets/buttons/custom_back_button.dart';
import '../../widgets/custom_circle_loading.dart';
import '../../widgets/custom_content_widget.dart';
import 'VideoReals/video_reels_screen.dart';

class SummerAllScreen extends StatefulWidget {
  const SummerAllScreen({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<SummerAllScreen> createState() => _SummerAllScreenState();
}

class _SummerAllScreenState extends State<SummerAllScreen> {
  final _controller = Get.put(CategoryByContentController());

  @override
  void initState() {
   selectGender();

    _controller.scrollController = ScrollController();
    _controller.scrollController.addListener(() {
      if (_controller.scrollController.position.pixels ==
          _controller.scrollController.position.maxScrollExtent) {
        _controller.loadMore(widget.categoryName);
      }
    });
    super.initState();

    DeviceUtils.authUtils();
  }

  selectGender()async{
    String gender= await PrefsHelper.getString(AppStrings.gender);
    _controller.selectGender.value =gender.isNotEmpty?gender:"All";
    _controller.fastLoad(widget.categoryName,false);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        key: scaffoldKey,
        endDrawer:  Drawer(
          backgroundColor: Colors.transparent,
          child: SearchEndDrawer(categoryName: widget.categoryName,),
        ),
        backgroundColor: AppColors.whiteBg,
        appBar: CustomAppBar(
            appBarContent: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBackButton(),
            Expanded(
              child: Text(
                widget.categoryName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.montserrat(
                  color: AppColors.black_100,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox()
          ],
        )),
        body: Obx(() {
          switch (_controller.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(onTap: () {
                _controller.fastLoad(widget.categoryName,false);
              });
            case Status.error:
              return GeneralErrorScreen(onTap: () {
                _controller.fastLoad(widget.categoryName,false);
              });
            case Status.completed:
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Expanded(
                            child: CustomSearchField(
                              onChanged: (value){
                                _controller.searchText.value=value??"";
                                _controller.fastLoad(widget.categoryName,true);
                                debugPrint(_controller.searchText.value);
                              },

                                hint: 'Search product')),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () =>
                              scaffoldKey.currentState!.openEndDrawer(),
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 11, vertical: 11),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.black_20, width: 1)),
                            child: SvgPicture.asset(AppIcons.adjustments),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Obx(() {
                      return _controller.searchLoading.value?const CustomCircleLoader():_controller.contentList.isEmpty?const Center(child: Text("No data found",style:TextStyle(fontSize:18,color:AppColors.black_40),),):SingleChildScrollView(
                        controller: _controller.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            MasonryGridView.builder(
                              shrinkWrap: true,
                              crossAxisSpacing: 8.w,
                              mainAxisSpacing: 8.h,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              itemCount: _controller.contentList.length,
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                var data = _controller.contentList[index];
                                return CustomContentCard(videoListModel: data,ontap:(){
                                  Get.to(CategoryByVideoReelsScreen(initIndex:index, categoryName:widget.categoryName,));
                                },);
                              },
                            ),
                            if (_controller.isLoadMoreRunning.value)
                              const SizedBox(
                                height: 10,
                              ),
                            if (_controller.isLoadMoreRunning.value)
                              const CustomCircleLoader(),

                              const SizedBox(
                                height: 100,
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              );
          }
        }),
      ),
    );
  }
}
