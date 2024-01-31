import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/helper/date_formate_helper.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/notification/Controller/notification_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/cache_nerwork_image.dart';
import 'package:runwey_trend/view/widgets/empty_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../utils/app_constent.dart';
import '../../widgets/buttons/custom_back_button.dart';
import '../../widgets/custom_circle_loading.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/general_error_screen.dart';
import '../../widgets/no_internet_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _controller = Get.put(NotificationController());

  @override
  void initState() {
    DeviceUtils.authUtils();
    _controller.fastLoad();
    _controller.scrollController = ScrollController();
    _controller.scrollController.addListener(() {
      if (_controller.scrollController.position.pixels ==
          _controller.scrollController.position.maxScrollExtent) {
        _controller.loadMore();
      }
    });
    super.initState();
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
            Text(
              AppStrings.notification,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: AppColors.black_100,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox()
          ],
        )),
        body: Obx(() {
          switch (_controller.rxRequestStatus.value) {
            case Status.loading:
              return const Scaffold(
                body: CustomLoader(),
              );
            case Status.internetError:
              return Scaffold(
                body: NoInternetScreen(onTap: () {
                  _controller.fastLoad();
                }),
              );
            case Status.error:
              return Scaffold(
                body: GeneralErrorScreen(onTap: () {
                  _controller.fastLoad();
                }),
              );
            case Status.completed:
              return body();
          }
        }),
      ),
    );
  }

  body() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Obx(()=>_controller.notificationList.isEmpty?const EmptyScreen():
           SingleChildScrollView(
            controller: _controller.scrollController,
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20,),
            child: Column(
              children: [
                Column(
                  children: List.generate(
                    _controller.notificationList.length,
                    (index){
                      var data =_controller.notificationList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.purple),
                          ),
                          child: ListTile(
                            leading:CustomNetworkImage(imageUrl:data.imageLink??"", height:50.w, width: 50.w,boxShape: BoxShape.circle,border: Border.all(color:AppColors.purple_10),),
                            title: Text(

                              data.message??"",
                              textAlign: TextAlign.start,
                              style:  TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,),
                            ),
                            subtitle: CustomText(
                              textAlign: TextAlign.start,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade800,
                              text:DateFormatHelper.timeAgoFormat(data.createdAt!),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if(_controller.isLoadMoreRunning.value)
                  const SizedBox(height: 10,),
                if(_controller.isLoadMoreRunning.value)
                  const CustomCircleLoader(),
                if(_controller.isLoadMoreRunning.value)
                  const SizedBox(height: 20,),
              ],
            ),
          ),
        );
      },
    );
  }
}
