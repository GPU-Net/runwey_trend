import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../../widgets/cache_nerwork_image.dart';
import '../../../profile/Controller/profile_controller.dart';

class TopSection extends StatefulWidget {
  const TopSection({super.key});

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {

  final _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(()=> Column(
        children: [

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
                height: 22,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: AppColors.yellow_10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    _profileController.profileData.value.subcriptionType??"",
                    style: GoogleFonts.poppins(
                      color: AppColors.yellow_100,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}