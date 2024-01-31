import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/personal_information/edit_your_information/inner_widgets/top_auth_section.dart';
import 'package:runwey_trend/view/screens/profile/Controller/profile_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';

import '../../../widgets/buttons/custom_back_button.dart';
import '../../../widgets/cache_nerwork_image.dart';

class EditYourInformationScreen extends StatefulWidget {
  const EditYourInformationScreen({Key? key}) : super(key: key);

  @override
  _EditYourInformationScreenState createState() => _EditYourInformationScreenState();
}

class _EditYourInformationScreenState extends State<EditYourInformationScreen> {

  final _profileController = Get.put(ProfileController());

  @override
  void initState() {
    DeviceUtils.authUtils();
    _profileController.updateData();
    super.initState();
  }
  // State variables

  // File? imageFile;
  // List<File> addImages = [];
  //
  // // Function to open the image gallery
  // void openGallery(BuildContext context) async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);
  //
  //   if (pickedFile != null) {
  //     imageFile = File(pickedFile.path);
  //     addImages.add(imageFile!);
  //     setState(() {
  //
  //     });
  //   }
  // }

  /*EditInformation controller = EditInformation();*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        appBar: CustomAppBar(
          appBarBgColor: AppColors.purple,
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(),
              Text(
                AppStrings.editYourInformation,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    _profileController.pickImage();
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Obx(()=>
                       SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: _profileController.imagePath.isEmpty?CustomNetworkImage(imageUrl:_profileController.profileData.value.image!.publicFileUrl??"", height:100, width:100,boxShape: BoxShape.circle,border:Border.all(
                                    color: Colors.grey.shade400,
                                    width: 1
                                ),):
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(_profileController.imagePath.value)),
                                    ),
                                  ),

                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomRight,
                                child:
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: AppColors.purple,
                                      shape: BoxShape.circle,
                                      // image: DecorationImage(image: AssetImage('assets/images/profile_icon.png')),
                                    ),
                                    child: const CustomImage(
                                      imageSrc: AppImages.profileIcon,
                                      imageType: ImageType.png,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              )

                            ]
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const TopAuthSection(),
                 SizedBox(height: 104.h),
                Obx(()=>
                   NewCustomButton(onTap:(){
                    _profileController.editProfile();
                  }, text:"Update",loading:_profileController.loading.value,),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}