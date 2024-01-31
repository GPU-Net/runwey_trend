import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/settings/change_password/Controller%20/change_password_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {


  final _changePasswordController = Get.put(ChangePasswordController());

  final GlobalKey<FormState>  _formKey= GlobalKey<FormState>();

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
      appBar:  CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(),
              CustomText(
                text: AppStrings.changePassword,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.black_100,
              ),
              SizedBox()
            ],
          )),
      body:  LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
              child:Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Current Password',
                      color: AppColors.black_100,
                      fontWeight: FontWeight.w400,
                      top: 16,
                      bottom: 8,
                    ),
                    CustomTextField(
                      isPassword: true,
                      textAlign: TextAlign.start,
                      textEditingController: _changePasswordController.oldPassword,
                      hintText: AppStrings.enterYourPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your old password';
                        }
                        return null;
                      },
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_40),
                      inputTextStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.black_100),
                      fieldBorderColor: AppColors.black_10,
                      fieldBorderRadius: 8,

                    ),
                    const CustomText(
                      text: AppStrings.newPassword,
                      color: AppColors.black_100,
                      fontWeight: FontWeight.w400,
                      top: 16,
                      bottom: 8,
                    ),

                    CustomTextField(
                      isPassword: true,
                      textEditingController: _changePasswordController.newPassword,
                      textAlign: TextAlign.start,
                      hintText: AppStrings.enterYourPassword,
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_40),
                      inputTextStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.black_100),
                      fieldBorderColor: AppColors.black_10,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      fieldBorderRadius: 8,
                    ),
                    const CustomText(
                      text: AppStrings.confirmPassword,
                      color: AppColors.black_100,
                      fontWeight: FontWeight.w500,
                      top: 16,
                      bottom: 8,
                    ),
                    CustomTextField(
                      isPassword: true,
                      textAlign: TextAlign.start,
                      hintText:"Re-write password",
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_40),
                      inputTextStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.black_100),
                      fieldBorderColor: AppColors.black_10,
                      fieldBorderRadius: 8,
                      textEditingController: _changePasswordController.confirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your confirm password';
                        } else if (value != _changePasswordController.newPassword.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },

                    ),
                    // GestureDetector(
                    //   onTap: (){
                    //     Get.toNamed(AppRoute.changeForgetPasswordScreen);
                    //   } ,
                    //   child: Align(
                    //     alignment: Alignment.topRight,
                    //     child: CustomText(
                    //       text: AppStrings.forgetPassword,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w500,
                    //       color: AppColors.purple,
                    //       top: 16,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          }
      ),
      bottomNavigationBar: Obx(()=> Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: NewCustomButton(text: 'Save', onTap: (){
          if(_formKey.currentState!.validate()){
            _changePasswordController.changePassword();
          }

        },loading: _changePasswordController.loading.value,),
      )),
    ));
  }
}
