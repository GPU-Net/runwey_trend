import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/model/category_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/occasions/Controller%20/occasions_controller.dart';
import 'package:runwey_trend/view/widgets/cache_nerwork_image.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../widgets/occasions_card.dart';

class OccasionsScreen extends StatefulWidget {
  const OccasionsScreen({super.key});

  @override
  State<OccasionsScreen> createState() => _OccasionsScreenState();
}

class _OccasionsScreenState extends State<OccasionsScreen> {
  final _occasionsController = Get.put(OccasionsController());
  @override
  void initState() {
    DeviceUtils.authUtils();
    _occasionsController.getCategory();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.purple,
          systemNavigationBarIconBrightness: Brightness.light));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            backgroundColor: AppColors.whiteBg,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.whiteBg,
              title: const CustomText(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                text: AppStrings.chooseYourOccasions,
              ),
              centerTitle: true,
            ),
            body: Obx(() {
              switch (_occasionsController.rxRequestStatus.value) {
                case Status.loading:
                  return const CustomLoader();
                case Status.error:
                  return GeneralErrorScreen(onTap: () {
                    _occasionsController.getCategory();
                  });
                case Status.internetError:
                  return NoInternetScreen(onTap: () {
                    _occasionsController.getCategory();
                  });
                case Status.completed:
                  return LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return MasonryGridView.builder(
                      shrinkWrap: true,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,

                      physics: const AlwaysScrollableScrollPhysics(),
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20,bottom:130),
                      itemCount: _occasionsController.categoryList.length,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        var data = _occasionsController.categoryList[index];
                        return OccasionsCard(categoryModel: data);
                      },
                    );
                  });
              }
            })
        )
    );
  }
}


