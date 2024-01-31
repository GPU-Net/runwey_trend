import 'package:flutter/material.dart';
import 'package:runwey_trend/view/screens/add/add/inner_widgets/add_upload_video_top_section.dart';
import 'package:runwey_trend/view/screens/add/add/inner_widgets/upload_video_end_drawer.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/image/custom_image.dart';
import '../../../../widgets/text/custom_text.dart';
import 'add_upload_video_section.dart';

class UploadVideoScreen extends StatelessWidget {
  const UploadVideoScreen({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const Drawer(child: UploadVideoEndDrawer()),
      backgroundColor: AppColors.whiteBg,
      appBar: const CustomAppBar(
        appBarContent: Center(
          child: CustomText(
            text: AppStrings.uploadVideo,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.black_100,
          ),
        ),
      ),
      body:
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Column(
                          children: [
                            const AddUploadVideoTopSection(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: AppStrings.uploadVideo,
                                  fontSize: 18,
                                  color: AppColors.black_100,
                                  fontWeight: FontWeight.w500,
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      scaffoldKey.currentState!.openEndDrawer(),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.black_20, width: 1)),
                                    child: const CustomImage(
                                      imageSrc: AppIcons.adjustments,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16, bottom: 24),
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: AppColors.black_40,
                            ),
                          ],
                        ),
                      ),


                      const Expanded(child:  AddUploadVideoSection())
                    ],
                  ),
                ),
              )),

    );
  }
}