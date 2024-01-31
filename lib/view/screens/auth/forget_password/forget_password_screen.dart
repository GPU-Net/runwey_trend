import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/auth/Controller/auth_controller.dart';
import 'package:runwey_trend/view/screens/auth/otp/otp_screen.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class Forget_Password_Screen extends StatefulWidget {
  const Forget_Password_Screen({super.key});

  @override
  State<Forget_Password_Screen> createState() => _Forget_Password_ScreenState();
}

class _Forget_Password_ScreenState extends State<Forget_Password_Screen> {
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
final _authController =Get.put(AuthController());
  final _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
          backgroundColor: AppColors.whiteBg,
          appBar:AppBar(
            title: const Text(AppStrings.forgetPassword),
            leading: const CustomBackButton(),
          ),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 24),
                child: Form(
                  key:_formKey,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 44,
                      ),
                      const Center(
                        child: CustomImage(
                            size: 120,
                            imageType: ImageType.png,
                            imageSrc: AppImages.passwordOutline1),
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      const CustomText(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_100,
                        text: AppStrings.enterEmailAddressToResetPassword,
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      const CustomText(
                        text: AppStrings.email,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_100,
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        textAlign: TextAlign.start,
                        hintText: 'Enter your email',
                        textEditingController: _authController.forgetEmailTextCtrl,
                        validator: (v){
                          if(v!.isEmpty&&!v.contains("@")){
                            return "Enter your valid email";
                          }
                        },
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
              );
            },
          ),
          bottomNavigationBar: Obx(()=>
             NewCustomButton(onTap:(){
                  if(_formKey.currentState!.validate()){
                    _authController.handleForget();
                  }
            }, text:AppStrings.getOTP,padding: EdgeInsets.symmetric(vertical: 20.h,horizontal:20.w),loading: _authController.forgotLoading.value,),
          ),
          // bottomNavigationBar: BottomNavButton(
          //   buttonText: AppStrings.getOTP,
          //   onTap: () {
          //
          //     if(_formKey.currentState!.validate()){
          //
          //       _authController.handleForget();
          //
          //     }
          //
          //
          //     // Get.to(() => const OtpScreen());
          //   },
          // )

      ),
    );
  }
}
