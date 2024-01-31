import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/auth/Controller/auth_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    DeviceUtils.allScreenUtils();
    super.initState();
  }
  @override
  void dispose() {
    DeviceUtils.screenUtils();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();

  var prameter=Get.arguments;

  final _authController = Get.put(AuthController());



  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
          appBar:AppBar(
            title: const Text(AppStrings.resetPassword),
            leading: const CustomBackButton(),
          ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return  SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 44,),
                     const Center(
                      child: CustomImage(
                          size: 120,
                          imageType: ImageType.png,
                          imageSrc: AppImages.authenticationOutline1
                      ),
                    ),
                    const SizedBox(height: 44,),
                     const Center(
                      child: CustomText(
                        fontSize: 14,
                        fontWeight:FontWeight.w500,
                        color: AppColors.black_100,
                        text: AppStrings.passwordMust,
                      ),
                    ),
                    const SizedBox(height: 44,),
                    const CustomText(
                      text: AppStrings.password,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_100,
                    ),
                    const SizedBox(height:8),
                    CustomTextField(
                      isPassword: true,
                      isPrefixIcon: false,
                      textEditingController: _authController.resetPassCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      textAlign: TextAlign.start,
                      hintText: 'Enter your password',
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_40),
                      inputTextStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.black_100),
                      fieldBorderColor: AppColors.black_20,
                      fieldBorderRadius: 8,
                    ),
                    const SizedBox(height: 24,),
                    const CustomText(
                      text: AppStrings.confirmPassword,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_100,
                    ),
                    const SizedBox(height:8),
                    CustomTextField(
                      isPassword: true,
                      isPrefixIcon: false,
                      textAlign: TextAlign.start,
                      textEditingController: _authController.resetConfirmPassCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your confirm password';
                        } else if (value != _authController.resetPassCtrl.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      hintText: 'Enter confirm password',
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_40),
                      inputTextStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.black_100),
                      fieldBorderColor: AppColors.black_20,
                      fieldBorderRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          );
        },),
          bottomNavigationBar:Obx(()=>
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: NewCustomButton(
                text: AppStrings.reset,
                onTap: () {
                  if(_formKey.currentState!.validate()){
                    _authController.handleResetPassword(prameter, _authController.resetConfirmPassCtrl.text);

                  }
                },
                loading: _authController.resetPasswordLoading.value,
            ),
             ),
          )
      ),
    );
  }
}
