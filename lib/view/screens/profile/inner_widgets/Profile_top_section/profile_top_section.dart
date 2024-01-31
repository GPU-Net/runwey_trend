import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/prefs_helper.dart';
import 'package:runwey_trend/helper/socket_maneger.dart';
import 'package:runwey_trend/services/socket_constant.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/screens/auth/Controller/auth_controller.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../Controller/profile_controller.dart';

class ProfileTopSection extends StatelessWidget {
  ProfileTopSection({super.key});

  final _profileController = Get.put(ProfileController());
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 12,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _customListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.personalInformation);
                  },
                  image: AppIcons.user2,
                  title: AppStrings.personalInformation),
              _buildDivider(),
              _customListTile(
                onTap: () {
                  Get.toNamed(AppRoute.myWishlistScreen);
                },
                image: AppIcons.heart,
                title: AppStrings.myWishList,
              ),
              _buildDivider(),
              _customListTile(
                onTap: () {
                  Get.toNamed(AppRoute.mySubscriptionPlanScreen);
                },
                image: AppIcons.crown2,
                title: AppStrings.mySubscriptionPlan,
              ),
              _buildDivider(),
              _customListTile(
                onTap: () {
                  Get.toNamed(AppRoute.purchaseSubscriptionScreen);
                },
                image: AppIcons.crown,
                title: AppStrings.purchaseSubscription,
              ),
              _buildDivider(),
              _customListTile(
                onTap: () async{
                   await _profileController.crateChatRoom();
                },
                image: AppIcons.chatAlt2,
                title: AppStrings.sendMessageToAdmin,
              ),
              _buildDivider(),
              _customListTile(
                onTap: () {
                  Get.toNamed(AppRoute.settingsScreen);
                },
                image: AppIcons.cog,
                title: AppStrings.settings,
              ),
              // _buildDivider(),
              // _customListTile(
              //   onTap: () {
              //     Get.toNamed(AppRoute.supportScreen);
              //   },
              //   image: AppIcons.support,
              //   title: AppStrings.support,
              // ),
              _buildDivider(),
              _customListTile(
                onTap: () {
                  _authController.signOut();
                },
                image: AppIcons.logout,
                title: AppStrings.logout,
                isLogout: true
              ),
            ],
          ),
        )
      ],
    );
  }

  _customListTile(
      {required String title, required String image, Function()? onTap , bool isLogout=false}) {
    return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(vertical: -4, horizontal: 0),
      horizontalTitleGap: 16.w,
      minVerticalPadding: 0,
      minLeadingWidth: 18,
      leading: CustomImage(
        size: 18,
        imageColor:isLogout?AppColors.red_100: AppColors.black_100,
        imageType: ImageType.svg,
        imageSrc: image,
        // imageSrc: AppIcons.user2
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500,color: isLogout?AppColors.red_100:AppColors.black_100),
      ),
    );
  }

  _buildDivider() => Padding(
        padding: EdgeInsets.only(top: 10.h, bottom:20.h),
        child: const Divider(
          height: 1,
          color: AppColors.purple_10,
        ),
      );
}
