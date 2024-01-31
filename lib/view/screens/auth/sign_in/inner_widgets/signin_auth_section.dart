import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/style.dart';
import 'package:runwey_trend/view/screens/auth/Controller/auth_controller.dart';
import 'package:runwey_trend/view/screens/botttom_nav_bar/bottom_nav_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import '../../../../../utils/app_constent.dart';

class SignInAuthSection extends StatefulWidget {
  const SignInAuthSection({super.key});

  @override
  State<SignInAuthSection> createState() => _SignInAuthSectionState();
}

class _SignInAuthSectionState extends State<SignInAuthSection> {
  final _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration:  ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFFDFBFB), Colors.white, Color(0xFFF4F4F4)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 44.h,),
              Text(AppStrings.email,style:AppStyles.h5(),),
              SizedBox(height: 8.h,),
              CustomTextField(
                textEditingController:_authController.signInEmailCtrl,
                textAlign: TextAlign.start,
                hintText: AppStrings.enterYourEmail,
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_40),
                inputTextStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.black_100),
                fieldBorderColor: AppColors.black_10,
                fieldBorderRadius: 8.r,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email!';
                  }else if(!AppConstants.emailValidate.hasMatch(value)){
                    return "Invalid email!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h,),
              Text(AppStrings.password,style:AppStyles.h5(),),
              SizedBox(height: 8.h,),
              CustomTextField(
                isPassword: true,
                textEditingController: _authController.signInPassCtrl,
                textAlign: TextAlign.start,
                hintText: AppStrings.enterYourPassword,
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_40),
                inputTextStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.black_100),
                fieldBorderColor: AppColors.black_10,
                fieldBorderRadius: 8.r,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },

              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoute.forgetPasswordScreen);
                },
                child:  Align(
                  alignment: Alignment.topRight,
                  child: CustomText(
                    text: AppStrings.forgetPassword,
                    fontWeight: FontWeight.w500,
                    color: AppColors.purple,
                    top: 16.h,
                    bottom: 24.h,
                  ),
                ),
              ),
              SizedBox(height:40.h,),
              Obx(()=>
                 NewCustomButton(onTap:(){
                  if(_formKey.currentState!.validate()){
                    _authController.handleSignIn();
                  }
                }, text:AppStrings.signIn,loading:_authController.signInLoading.value,),
              ),
              //  Align(
              //   alignment: Alignment.center,
              //   child: CustomText(
              //     text: AppStrings.or,
              //     fontWeight: FontWeight.w500,
              //     color: AppColors.black_100,
              //     top: 16.h,
              //     bottom: 16.h,
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       height: 44.w,
              //       width: 44.w,
              //       decoration:  ShapeDecoration(
              //         color: Colors.white,
              //         shape: const OvalBorder(),
              //         shadows: [
              //           BoxShadow(
              //             color: const Color(0x19000000),
              //             blurRadius: 4.r,
              //             offset: const Offset(0, 0),
              //             spreadRadius: 0,
              //           )
              //         ],
              //       ),
              //       child: const CustomImage(
              //         imageSrc: AppIcons.google,
              //       ),
              //     ),
              //     SizedBox(width: 44.w,),
              //     Container(
              //       height: 44.w,
              //       width: 44.w,
              //       decoration: const ShapeDecoration(
              //         color: Colors.white,
              //         shape: OvalBorder(),
              //         shadows: [
              //           BoxShadow(
              //             color: Color(0x19000000),
              //             blurRadius: 4,
              //             offset: Offset(0, 0),
              //             spreadRadius: 0,
              //           )
              //         ],
              //       ),
              //       child: const CustomImage(
              //         imageSrc: AppIcons.apple,
              //       ),
              //     ),
              //   ],
              // ),
               SizedBox(height:100.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   CustomText(
                    text: AppStrings.didNotHaveAnAccount,
                    color: AppColors.black_100,
                    top: 16.h,
                    bottom: 16.h,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.signUpScreen);
                    },
                    child:  CustomText(
                      text: AppStrings.signUp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.purple,
                      top: 16.h,
                      bottom: 16.h,
                      left: 4.w,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

      ),
    );
  }
}
