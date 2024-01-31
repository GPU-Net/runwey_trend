import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/view/screens/profile/Controller/profile_controller.dart';
import 'package:runwey_trend/view/screens/profile/inner_widgets/Profile_top_section/profile_top_section.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';

import '../../../utils/device_utils.dart';
import 'inner_widgets/profile_bottom_card_section/profile_bottom_card_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileController = Get.put(ProfileController());

  @override
  void initState() {
    DeviceUtils.profileUtils();
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor:AppColors.purple));
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.screenUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        switch (_profileController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: () {
              _profileController.getProfileData();
            });
          case Status.error:
            return GeneralErrorScreen(onTap: () {
              _profileController.getProfileData();
            });
          case Status.completed:
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: const ShapeDecoration(
                        color: AppColors.purple,
                        image: DecorationImage(
                            image: AssetImage(AppImages.design)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                     SingleChildScrollView(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 20, vertical: 24),
                      child: Column(
                        children: [
                          ProfileBottomCardSection(),
                          const SizedBox(height: 40),
                           ProfileTopSection(),
                          const SizedBox(
                            height: 44,
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            );
        }
      }),
    ));
  }
}
