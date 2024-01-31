import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/screens/profile/Controller/profile_controller.dart';
import 'package:runwey_trend/view/widgets/cache_nerwork_image.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class ProfileBottomCardSection extends StatelessWidget {
   ProfileBottomCardSection({super.key});

  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomText(
          top: 44,
          text: AppStrings.profile,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          bottom: 40,
        ),
        CustomNetworkImage(imageUrl:_profileController.profileData.value.image!.publicFileUrl??"", height:80, width:80,boxShape: BoxShape.circle,border:Border.all(
          color: Colors.grey.shade400,
          width: 1
        ),),
         CustomText(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
          top: 16,
          text: _profileController.profileData.value.fullName??"",
          bottom: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomImage(
                size: 20,
                imageType: ImageType.svg,
                imageSrc: AppIcons.crown
            ),
            const SizedBox(width: 8,),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFF0E8FC),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: Text(
                _profileController.profileData.value.subcriptionType??"",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF6611E0),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

