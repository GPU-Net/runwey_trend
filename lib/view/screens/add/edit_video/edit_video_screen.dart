import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:runwey_trend/model/content_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/add/edit_video/Controller/edit_product_controller.dart';
import 'package:runwey_trend/view/screens/add/edit_video/inner_widgets/edit_video_bottom_section.dart';
import 'package:runwey_trend/view/screens/add/edit_video/inner_widgets/edit_video_top_section.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_back_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import 'inner_widgets/edit_video_middle_section.dart';

class EditVideoScreen extends StatefulWidget {
  const EditVideoScreen({super.key, required this.contentModel});
  final ContentModel contentModel;
  @override
  State<EditVideoScreen> createState() => _EditVideoScreenState();
}

class _EditVideoScreenState extends State<EditVideoScreen> {
  final _editController = Get.put(EditVideoController());
  @override
  void initState() {
    _editController.getCategory(widget.contentModel);
    DeviceUtils.authUtils();
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
              const CustomText(
                text: 'Edit Product',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.black_100,
              ),
              const SizedBox()
            ],
          )),
          body: Obx(() {
            switch (_editController.rxRequestStatus.value) {
              case Status.loading:
                return CustomLoader();
              case Status.internetError:
                return NoInternetScreen(onTap: () {
                  _editController.getCategory(widget.contentModel);
                });
              case Status.error:
                return GeneralErrorScreen(onTap: () {
                  _editController.getCategory(widget.contentModel);
                });
              case Status.completed:
                return LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditVideoTopSection(
                            contentModel: widget.contentModel,
                          ),
                          const EditVideoMiddleSection(),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(()=>
                             NewCustomButton(
                                onTap: () {
                                  if(_editController.formKey.currentState!.validate()){
                                    _editController.uploadVideo(_editController.videoFilePath.value,widget.contentModel.id??"");
                                  }
                                }, text: AppStrings.upload,loading: _editController.uploadLoading.value,),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ));
                });
            }
          }),
        ));
  }
}
