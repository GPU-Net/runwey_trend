import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import '../../../auth/sign_up/sign_up_auth_section.dart';
import '../../../profile/Controller/profile_controller.dart';


class TopAuthSection extends StatefulWidget {
  const TopAuthSection({super.key});

  @override
  State<TopAuthSection> createState() => _TopAuthSectionState();
}

class _TopAuthSectionState extends State<TopAuthSection> {
  final _profileController = Get.put(ProfileController());

  List<String> genderList = ["Male", "Female"];
  int selectedGender = 0;
  bool isClicked=false;
  void changeGender(int index) {
    selectedGender = index;
    setState(() {

    });
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "Name",
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            textEditingController: _profileController.nameCtrl,
            hintText: AppStrings.enterYourName,
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
            validator: (value){
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
            },


          ),
          const CustomText(
            text: AppStrings.dateOfBirth,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            bottom: 8,
            top: 16,
          ),
          CustomTextField(
            textEditingController: _profileController.dobCtrl,
            readOnly: true,
            onTap: ()async{
              await _profileController.selectDate(context);
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
              await _profileController.selectDate(context);

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


          // const CustomText(
          //   text: AppStrings.gender,
          //   color: AppColors.black_100,
          //   fontWeight: FontWeight.w400,
          //   bottom: 8,
          //   top: 16,
          // ),
          // Obx(()=>
          //     Row(
          //       children: List.generate(_profileController.genderList.length, (index) => Padding(
          //         padding: const EdgeInsets.only(right: 24),
          //         child: GestureDetector(
          //           onTap: () => _profileController.changeGender(index),
          //           child: Row(
          //             children: [
          //               Container(
          //                 height: 20, width: 20,
          //                 padding: const EdgeInsetsDirectional.all(0.5),
          //                 decoration: BoxDecoration(
          //                     color: Colors.transparent,
          //                     border: Border.all(color: AppColors.purple),
          //                     shape: BoxShape.circle
          //                 ),
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                       color: index == _profileController.selectedGender.value? AppColors.purple : Colors.transparent,
          //                       shape: BoxShape.circle
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(width: 8),
          //               Text(
          //                 _profileController.genderList[index],
          //                 style: GoogleFonts.poppins(
          //                     color: AppColors.black_100,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w500
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       )),
          //     ),
          // ),
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
                    initialSelection:_profileController.phoneCode.value,
                    onChanged: (value) {
                      _profileController.phoneCode.value=value.dialCode!;
                      print(_profileController.phoneCode.value);
                    },
                    //showFlag: true,

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
                  textEditingController: _profileController.phoneCtrl,
                  hintStyle: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_40),
                  inputTextStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.black_100),
                  fieldBorderColor: AppColors.black_10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  fieldBorderRadius: 8,
                  keyboardType: TextInputType.number,
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
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Expanded(
          //         flex: 1,
          //         child: Container(
          //             height: 60,
          //             padding:  const EdgeInsets.symmetric(
          //                 vertical: 6, horizontal: 8),
          //             decoration: BoxDecoration(
          //                 color: AppColors.white,
          //                 borderRadius: BorderRadius.circular(8),
          //                 border:
          //                 Border.all(color:  AppColors.black_10)),
          //             child: IntlPhoneField(
          //               initialCountryCode: 'MX',
          //               disableLengthCheck: true,
          //               showDropdownIcon: false,
          //               showCountryFlag: true,
          //               decoration: const InputDecoration(
          //                   border: OutlineInputBorder(
          //                     borderSide: BorderSide.none,
          //                   )
          //               ),
          //               onChanged: (phone) {
          //                 print(phone.completeNumber);
          //               },
          //             )
          //
          //         )),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //       flex: 2,
          //       child: CustomTextField(
          //         textAlign: TextAlign.start,
          //         hintText: AppStrings.enterYourEmail,
          //         hintStyle: GoogleFonts.montserrat(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w500,
          //             color: AppColors.black_40),
          //         inputTextStyle: GoogleFonts.montserrat(
          //             fontWeight: FontWeight.w400,
          //             fontSize: 14,
          //             color: AppColors.black_100),
          //         fieldBorderColor: AppColors.black_10,
          //         fieldBorderRadius: 8,
          //
          //       ),
          //     ),
          //
          //   ],
          // ),

          // const CustomText(
          //   text: AppStrings.email,
          //   color: AppColors.black_100,
          //   fontSize: 14,
          //   fontWeight: FontWeight.w400,
          //   top: 16,
          //   bottom: 8,
          //
          // ),
          // CustomTextField(
          //   textAlign: TextAlign.start,
          //   readOnly: true,
          //   textEditingController: _profileController.emailCtrl,
          //   hintText: AppStrings.enterYourEmail,
          //   hintStyle: GoogleFonts.montserrat(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w500,
          //       color: AppColors.black_40),
          //   inputTextStyle: GoogleFonts.montserrat(
          //       fontWeight: FontWeight.w400,
          //       fontSize: 14,
          //       color: AppColors.black_100),
          //   fieldBorderColor: AppColors.black_10,
          //   fieldBorderRadius: 8,
          //
          // ),
        ],
      ),);
  }
}