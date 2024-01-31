import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/model/content_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/add/show_my_video/inner_widgets/show_my_video_bottom_section.dart';
import 'package:runwey_trend/view/screens/add/show_my_video/inner_widgets/show_my_video_top_section.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../widgets/buttons/custom_back_button.dart';
import '../../video_reels/Controller/url_video_controller.dart';
import '../Controller/controller_add_video.dart';
import '../edit_video/edit_video_screen.dart';
import '../upload_video_details/inner_widgets/success_dialog.dart';
import 'Controller/show_my_video_contorller.dart';
import 'inner_widgets/custom_alert_box.dart';

class ShowMyVideoScreen extends StatefulWidget {
  const ShowMyVideoScreen({super.key, required this.contentModel});
  final ContentModel contentModel;
  @override
  State<ShowMyVideoScreen> createState() => _ShowMyVideoScreenState();
}

class _ShowMyVideoScreenState extends State<ShowMyVideoScreen> {

  final _showMyVideoController = Get.put(ShowMyVideoController());
  final _urlVideoController = Get.put(UrlVideoWidgetController());



  @override
  void initState() {
    DeviceUtils.authUtils();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Obx(()=>_showMyVideoController.loading.value? const Scaffold(body: CustomLoader(),):
           Scaffold(
            backgroundColor: AppColors.whiteBg,
            appBar: CustomAppBar(
                appBarContent: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(),
                  Expanded(
                    child: CustomText(
                      text: widget.contentModel.title ?? "",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_100,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton(
                    shadowColor: const Color(0x19000000),
                    shape: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8)),
                      borderSide: BorderSide(width: 1, color: AppColors.black_10),
                    ),
                    color: AppColors.white,
                    icon: const Icon(
                      Icons.more_vert_outlined,
                      color: AppColors.black_100,
                    ),
                    elevation: 0,
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: (){

                          Get.to(EditVideoScreen(contentModel: widget.contentModel,));
                          _urlVideoController.videoPlayerController.pause();
                          _urlVideoController.chewieController.pause();
                        },
                          child: const Row(
                            children: [
                              CustomImage(
                                imageSrc: AppIcons.externalLink,
                                imageColor: AppColors.black_100,
                                size: 18,
                              ),
                              CustomText(
                                text: 'Edit',
                                color: AppColors.black_100,
                                left: 18,
                              )
                            ],
                          )),
                      PopupMenuItem(
                        onTap: (){
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return  CustomAlertBox( id:widget.contentModel.id??"");
                            },
                          );
                        },
                        child: const Row(
                          children: [
                            CustomImage(
                              imageSrc: AppIcons.trash,
                              imageColor: AppColors.red_100,
                              size: 18,
                            ),
                            CustomText(
                              text: 'Delete',
                              color: AppColors.red_100,
                              left: 18,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ])),
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    children: [
                      ShowMyVideoTopSection(
                        contentModel: widget.contentModel,
                      ),
                      ShowMyVideoBottomSection(contentModel: widget.contentModel)
                    ],
                  ));
            }),
          ),
        ));
  }
}
