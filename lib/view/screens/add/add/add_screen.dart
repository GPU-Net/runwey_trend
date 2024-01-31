import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/add/Controller/controller_add_video.dart';
import 'package:runwey_trend/view/screens/add/Controller/question_controller.dart';
import 'package:runwey_trend/view/screens/add/add/inner_widgets/add_upload_video_section.dart';
import 'package:runwey_trend/view/screens/add/add/inner_widgets/add_upload_video_top_section.dart';
import 'package:runwey_trend/view/screens/add/add/inner_widgets/upload_video_end_drawer.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import 'inner_widgets/admin_permit_section.dart';
import 'inner_widgets/content_creator_section.dart';
import 'inner_widgets/upload_first_video_section.dart';
import 'inner_widgets/upload_video_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final _questionController = Get.put(QuestionController());
  final _addController = Get.put(AddVideoController());

  @override
  void initState() {
    DeviceUtils.authUtils();
    _addController.getPermission();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.purple,
          systemNavigationBarIconBrightness: Brightness.light));
    }
    super.initState();
  }
  @override
  void dispose() {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.purple,
          systemNavigationBarIconBrightness: Brightness.light));
    }
    // TODO: implement dispose
    super.dispose();
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      switch(_addController.rxRequestStatus.value){
        case Status.loading:
          return CustomLoader();
        case Status.internetError:
          return NoInternetScreen(onTap:(){
            _addController.getPermission();
          });
        case Status.error:
          return GeneralErrorScreen(onTap:(){
            _addController.getPermission();
          });
        case Status.completed:
          if(_addController.contentWritingPermission.value==ContentPermission.creator.name){
            if(_addController.isSearch.value || _addController.allMyContentList.isNotEmpty){
              return UploadVideoScreen(scaffoldKey:scaffoldKey);
            }
            return const UploadFirstVideoSection();

          }else if(_addController.contentWritingPermission.value==ContentPermission.pendingCreator.name){
            return  const AdminPermitSection();
          }
          else{
            return const ContentCreatorSection();
          }
      }

    });
    // Scaffold(
    //   key: scaffoldKey,
    //   endDrawer: const Drawer(child: UploadVideoEndDrawer()),
    //   backgroundColor: AppColors.whiteBg,
    //   appBar: const CustomAppBar(
    //     appBarContent: Center(
    //       child: CustomText(
    //         text: AppStrings.uploadVideo,
    //         fontSize: 18,
    //         fontWeight: FontWeight.w500,
    //         color: AppColors.black_100,
    //       ),
    //     ),
    //   ),
    //   body: LayoutBuilder(
    //       builder: (BuildContext context, BoxConstraints constraints) =>
    //           Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
    //             child: Center(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Expanded(
    //                     flex: 0,
    //                     child: Column(
    //                       children: [
    //                         const AddUploadVideoTopSection(),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             const CustomText(
    //                               text: AppStrings.uploadVideo,
    //                               fontSize: 18,
    //                               color: AppColors.black_100,
    //                               fontWeight: FontWeight.w500,
    //                             ),
    //                             GestureDetector(
    //                               onTap: () =>
    //                                   scaffoldKey.currentState!.openEndDrawer(),
    //                               child: Container(
    //                                 padding: const EdgeInsets.all(8),
    //                                 alignment: Alignment.center,
    //                                 decoration: BoxDecoration(
    //                                     color: AppColors.white,
    //                                     borderRadius: BorderRadius.circular(8),
    //                                     border: Border.all(
    //                                         color: AppColors.black_20, width: 1)),
    //                                 child: const CustomImage(
    //                                   imageSrc: AppIcons.adjustments,
    //                                   size: 24,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         Container(
    //                           margin: const EdgeInsets.only(top: 16, bottom: 24),
    //                           width: MediaQuery.of(context).size.width,
    //                           height: 1,
    //                           color: AppColors.black_40,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const Expanded(child:  AddUploadVideoSection())
    //                 ],
    //               ),
    //             ),
    //           )),
    // );


  }
}


