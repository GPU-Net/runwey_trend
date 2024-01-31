import 'dart:io';
import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/screens/auth/Controller/auth_controller.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

class SignUpAuthSection extends StatefulWidget {
  const SignUpAuthSection({super.key});

  @override
  State<SignUpAuthSection> createState() => _SignUpAuthSectionState();
}

class _SignUpAuthSectionState extends State<SignUpAuthSection> {


  final _authController =Get.put(AuthController());


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: AppStrings.fullName,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            hintText: AppStrings.enterYourName,
            textEditingController: _authController.nameCtrl,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name!';
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
            text: AppStrings.dateOfBirth,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            bottom: 8,
            top: 16,
          ),
          CustomTextField(
            textEditingController: _authController.dobCtrl,
            readOnly: true,
            onTap: ()async{
              await _authController.selectDate(context);
            },
            textAlign: TextAlign.center,
            hintText: AppStrings.dobHintText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your date of birth!';
              }
              else if(value.length<8){
                return "Invalid Date of Birth";
              }
              return null;
            },

            keyboardType: TextInputType.datetime,
            inputFormatters: [
              DateTextFormatter()
            ],
            suffixIcon: GestureDetector(onTap:()async{
              await _authController.selectDate(context);

            }, child:  Icon(Icons.date_range_outlined,color:Colors.grey.shade500,)),
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
            text: AppStrings.gender,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            bottom: 8,
            top: 16,
          ),
          Obx(()=>
             Row(
              children: List.generate(_authController.genderList.length, (index) => Padding(
                padding: const EdgeInsets.only(right: 24),
                child: GestureDetector(
                  onTap: () => _authController.changeGender(index),
                  child: Row(
                    children: [
                      Container(
                        height: 20, width: 20,
                        padding: const EdgeInsetsDirectional.all(0.5),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: AppColors.purple),
                            shape: BoxShape.circle
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: index == _authController.selectedGender.value? AppColors.purple : Colors.transparent,
                              shape: BoxShape.circle
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _authController.genderList[index],
                        style: GoogleFonts.poppins(
                            color: AppColors.black_100,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
          ),
          const CustomText(
            text: AppStrings.email,
            color: AppColors.black_100,
            fontWeight: FontWeight.w500,
            top: 16,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            hintText: AppStrings.enterYourEmail,
            textEditingController: _authController.emailCtrl,
           // autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email!';
              }else if(!AppConstants.emailValidate.hasMatch(value)){
                return "Invalid email!";
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
            text: AppStrings.phoneNumber,
            color: AppColors.black_100,
            top: 16,
            bottom: 8,

          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child:Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical:4 ),
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: const Color(0xFFEBEBEB)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child:CountryCodePicker(
                      initialSelection: _authController.phoneCode.value,

                      onChanged: (value) {
                        _authController.phoneCode.value=value.dialCode!;
                        print(_authController.phoneCode.value);
                      },
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),),
          ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: CustomTextField(
                  textAlign: TextAlign.start,
                  hintText: AppStrings.phoneNumber,
                  textEditingController: _authController.phoneCtrl,
                  hintStyle: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_40),
                  inputTextStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.black_100),
                  fieldBorderColor: AppColors.black_10,
                    keyboardType: Platform.isIOS?
                    const TextInputType.numberWithOptions(signed: true, decimal: true)
                        : TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  fieldBorderRadius: 8,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone';
                    } else if (value.length > 10) {
                      return 'Password must be at least 10 characters';
                    }
                    return null;
                  },

                ),
              ),

            ],
          ),
          const CustomText(
            text: AppStrings.password,
            color: AppColors.black_100,
            fontWeight: FontWeight.w500,
            top: 16,
            bottom: 8,
          ),
          CustomTextField(
            isPassword: true,
            textEditingController: _authController.passwordCtrl,
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

            hintText: AppStrings.confirmPassword,
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
            textEditingController: _authController.conPasswordCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your confirm password';
              } else if (value != _authController.passwordCtrl.text) {
                return 'Passwords do not match';
              }
              return null;
            },

          ),
          SizedBox(height: 24.h,),

          Obx(()=>NewCustomButton(onTap: (){
    if(_formKey.currentState!.validate()){
        _authController.handleSignUp();
      }
          }, text:AppStrings.signUp,
          loading: _authController.signUpLoading.value,
          ))

          // CustomButton(
          //   buttonWidth: MediaQuery.of(context).size.width,
          //   onPressed: () {
          //   if(_formKey.currentState!.validate()){
          //     _authController.handleSignUp();
          //   }
          //   },
          //   titleText: AppStrings.signUp,
          //   titleColor: AppColors.white,
          //   buttonBgColor: AppColors.purple,
          //   titleSize: 18,
          //   titleWeight: FontWeight.w600,
          //   topPadding: 17,
          //   bottomPadding: 17,
          //
          // ),
        ],
      ),);
  }
}



class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var text = _format(newValue.text, '/');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String separator) {
    value = value.replaceAll(separator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 3 || i == 5) && i != value.length - 1) {
        newString += separator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}


