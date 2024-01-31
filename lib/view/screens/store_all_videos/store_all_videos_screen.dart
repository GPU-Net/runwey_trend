import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/store_all_videos/inner_widgets/all_videos_section.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:video_player/video_player.dart';

import '../../../model/content_details_model.dart';
import '../../widgets/buttons/custom_back_button.dart';
import '../../widgets/cache_nerwork_image.dart';
import 'Controller/store_controller.dart';

class StoreAllVideoScreen extends StatefulWidget {
  const StoreAllVideoScreen({super.key,required this.userId});
  final UserId userId;
  @override
  State<StoreAllVideoScreen> createState() => _StoreAllVideoScreenState();
}

class _StoreAllVideoScreenState extends State<StoreAllVideoScreen> {
  final _controller = Get.put(StoreAllVideoController());
  @override
  void initState() {
    super.initState();
    DeviceUtils.screenUtils();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _controller.fastLoad(widget.userId.id!);
        _controller.scrollController = ScrollController();
        _controller.scrollController.addListener(() {
          if (_controller.scrollController.position.pixels ==
              _controller.scrollController.position.maxScrollExtent) {
            _controller.loadMore(widget.userId.id!);
          }
        });

      });
    });

    DeviceUtils.authUtils();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        appBar: CustomAppBar(
            appBarContent: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBackButton(),
            Expanded(
              child: Text(
               "${AppStrings.allVideosOfLeroseStore}${widget.userId.fullName}",
               textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
        body: Obx((){
          switch (_controller.rxRequestStatus.value){
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(onTap:(){_controller.fastLoad(widget.userId.id!);});
            case Status.error :
              return GeneralErrorScreen(onTap: (){_controller.fastLoad(widget.userId.id!);});
            case Status.completed:
              return  SingleChildScrollView(
               controller: _controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),

                child: Column(
                  children: [
                    Center(
                      child:CustomNetworkImage(imageUrl:widget.userId.image!.publicFileUrl!, height:72.w, width: 72.w,boxShape: BoxShape.circle,border: Border.all(color:AppColors.purple.withOpacity(0.3),width:0.5),),

                    ),
                    CustomText(
                      top: 8,
                      text: widget.userId.fullName??"",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      bottom: 16,
                    ),
                    Divider(
                      height: 1,
                      color: AppColors.black_20,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    AllVideoSection(userId: widget.userId.id??"",)
                  ],
                ),
              );
          }
        }),
      ),
    );
  }
}
