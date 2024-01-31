import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/helper/date_formate_helper.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../profile/Controller/profile_controller.dart';

class BottomCardSection extends StatefulWidget {
  const BottomCardSection({super.key});

  @override
  State<BottomCardSection> createState() => _BottomCardSectionState();
}

class _BottomCardSectionState extends State<BottomCardSection> {

  final _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {

    return Obx(()=>
       Container(
        width: MediaQuery.of(context).size.width,

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
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
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomImage(
                    size: 18,
                    imageColor: AppColors.black_100,
                    imageType: ImageType.svg,
                    imageSrc: AppIcons.user
                ),
                Flexible(
                  child: CustomText(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    left: 16,
                    text: _profileController.profileData.value.fullName??"",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            const Divider(height:1,color: AppColors.purple_10,),
            if(_profileController.profileData.value.dateOfBirth!=null)
            const SizedBox(height: 32,),
            if(_profileController.profileData.value.dateOfBirth!=null)
            Row(
              children: [
                const CustomImage(
                    size: 18,
                    imageColor: AppColors.black_100,
                    imageType: ImageType.svg,
                    imageSrc: AppIcons.birthday
                ),
                Flexible(
                  child:CustomText(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    left: 16,
                    text:DateFormatHelper.formatDate(_profileController.profileData.value.dateOfBirth!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Divider(height:1,color: AppColors.purple_10,),
            SizedBox(height: 32,),
            Row(
              children: [
                CustomImage(
                    size: 18,
                    imageColor: AppColors.black_100,
                    imageType: ImageType.svg,
                    imageSrc: AppIcons.gander
                ),
                CustomText(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  left: 16,
                  text: _profileController.profileData.value.gender??"",
                ),
              ],
            ),
            SizedBox(height: 16,),
            Divider(height:1,color: AppColors.purple_10,),
            SizedBox(height: 32,),
            Row(
              children: [
                CustomImage(
                    size: 18,
                    imageColor: AppColors.black_100,
                    imageType: ImageType.svg,
                    imageSrc: AppIcons.phone
                ),
                Flexible(
                  child: CustomText(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    left: 16,
                    text: "${ _profileController.profileData.value.countryCode??""}  ${ _profileController.profileData.value.phoneNumber??""}",
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Divider(height:1,color: AppColors.purple_10,),
            SizedBox(height: 32,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(
                    size: 18,
                    imageColor: AppColors.black_100,
                    imageType: ImageType.svg,
                    imageSrc: AppIcons.mail
                ),
                Flexible(
                  child: CustomText(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    left: 16,
                    text:  _profileController.profileData.value.email??"",
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Divider(height:1,color: AppColors.purple_10,),
          ],
        ),
      ),
    );
  }
}