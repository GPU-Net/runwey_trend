import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/auth/Controller/auth_controller.dart';
import 'package:runwey_trend/view/screens/auth/reset_password/reset_password_screen.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  var prameters = Get.parameters;

  final _authController =Get.put(AuthController());
  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    DeviceUtils.allScreenUtils();
    super.initState();
  }
  @override
  void dispose() {
    DeviceUtils.allScreenUtils();
    myController.dispose();
    super.dispose();
  }
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
          appBar:AppBar(
            title: const Text(AppStrings.verify),
            leading: const CustomBackButton(),
          ),
          body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return    SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
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
                          imageSrc: AppImages.passwordOutline1
                      ),
                    ),
                    const SizedBox(height: 44,),
                    const Center(
                      child: CustomText(
                        fontSize: 14,
                        fontWeight:FontWeight.w500,
                        color: AppColors.black_100,
                        text: AppStrings.pleaseEnterTheOTPCode,
                      ),
                    ),
                    const SizedBox(height: 44,),
                    PinCodeTextField(
                      cursorColor: AppColors.purple,
                      appContext: (context),
                      keyboardType: TextInputType.number,
                      autoDisposeControllers: false,
                      validator: (value){
                        if (value!.length <= 6) {
                          return null;
                        } else {
                          return "Please enter the OTP code sent to your mail.";
                        }
                      },
                      autoFocus: true,
                      controller:myController,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 56.h,
                        fieldWidth: 44.w,
                        activeFillColor: Colors.transparent,
                        selectedFillColor: Colors.transparent,
                        inactiveFillColor: Colors.transparent,
                        borderWidth: 0.1,
                        errorBorderColor: AppColors.black_10,
                        selectedColor: AppColors.purple,
                        activeColor: AppColors.black_10,
                        inactiveColor: const Color(0xFFCCCCCC),
                      ),
                      length: 6,
                      enableActiveFill: true,
                    ),
                    const SizedBox(height: 16),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: AppStrings.didNotGetOTP,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black_100,
                        ),
                        GestureDetector(
                          onTap: () {
                            _authController.handleResendOtp(prameters['email']!);
                          },
                          child: const CustomText(
                            text: AppStrings.resendOTP,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.purple,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          },
          ),
          bottomNavigationBar: Obx(()=>
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: NewCustomButton(onTap: () {
                if(_formKey.currentState!.validate()){
                  _authController.handleOtpVery(email:prameters['email']!,
                      otp:myController.text,
                      type:prameters['screenType']! );
                }
            }, text:AppStrings.verify,
               loading: _authController.verifyLoading.value,
               ),
             ),
          ),
          // bottomNavigationBar:BottomNavButton(
          //   buttonText: AppStrings.verify,
          //   onTap: () {
          //     Get.to(()=> const ResetPasswordScreen());
          //   },
          //
          // )
      ),
    );
  }
}
