import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';

import '../../../widgets/buttons/custom_back_button.dart';
import 'inner_widgets/bottom_card_section.dart';
import 'inner_widgets/top_section.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  void initState() {
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
            appBarBgColor: AppColors.purple,
            appBarContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomBackButton(color: Colors.white,),
                Text(
                  AppStrings.personalInformation,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color:  AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox()
              ],)),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return  Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: const ShapeDecoration(
                  color: AppColors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
              ),
              const SingleChildScrollView(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  children: [
                    TopSection(),
                    SizedBox(height: 40),
                    BottomCardSection(),
                  ],
                ),
              )
            ],
          );
        },
        ),
        bottomNavigationBar: BottomNavButton(
          buttonText: "Edit",
          onTap: () {
            Get.toNamed(AppRoute.editYourInformation);
          },
        ),
      ),
    );
  }
}