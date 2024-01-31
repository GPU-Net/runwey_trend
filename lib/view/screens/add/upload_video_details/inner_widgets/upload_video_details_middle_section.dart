import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/screens/add/upload_video_details/Controller/upload_video_controller.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import '../../../../widgets/buttons/new_custom_button.dart';

class UploadVideoDetailsMiddleSection extends StatefulWidget {
         UploadVideoDetailsMiddleSection({super.key,required this.path});
String path;
  @override
  State<UploadVideoDetailsMiddleSection> createState() => _UploadVideoDetailsMiddleSectionState();
}

class _UploadVideoDetailsMiddleSectionState extends State<UploadVideoDetailsMiddleSection> {

  final _uploadController =Get.put(UploadVideoController());
  List<String> sizeDetails = [
    's',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL',
  ];

  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  int selectedItem = 0;
  validateTextField(String value) {
    if (value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: AppStrings.title,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 32,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            textEditingController:_uploadController.titleTextCtrl,

            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
              }
              return null;
            },
            hintText: 'Enter title name',
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
            text: AppStrings.productDetails,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.black_100,
            top: 24,
            bottom: 16,
          ),
          const CustomText(
            text: AppStrings.size,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            bottom: 16,
          ),
          GridView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: sizeDetails.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 0,
                  mainAxisExtent: 40
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => setState(() {
                  selectedItem = index;
                  _uploadController.selectSize.value=sizeDetails[index];
                }),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: AppColors.purple, width: 1),
                          color: index == selectedItem
                              ? AppColors.purple
                              : AppColors.white,
                        ),
                      ),
                      CustomText(
                        text: sizeDetails[index],
                        color: AppColors.black_100,
                        fontWeight: FontWeight.w500,
                        left: 8,
                      ),
                    ],
                  ),
                ),
              )
          ),
          // const CustomText(
          //   text: AppStrings.gender,
          //   color: AppColors.black_100,
          //   fontWeight: FontWeight.w600,
          //  // top: 16,
          //   bottom: 8,
          // ),
          // Row(children:List.generate(_uploadController.genderList.length, (index) => GestureDetector(
          //   onTap: () => setState(() {
          //     _uploadController.selectGenderIndex.value = index;
          //   }),
          //   child: Container(
          //     margin:  EdgeInsets.only(bottom: 8,right: 44.w),
          //     decoration: ShapeDecoration(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     child: Row(
          //       children: [
          //         Container(
          //           height: 20,
          //           width: 20,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(50),
          //             border: Border.all(
          //                 color: AppColors.purple, width: 1),
          //             color: index == _uploadController.selectGenderIndex.value
          //                 ? AppColors.purple
          //                 : AppColors.white,
          //           ),
          //         ),
          //         CustomText(
          //           text: _uploadController.genderList[index],
          //           color: AppColors.black_100,
          //           fontWeight: FontWeight.w500,
          //           left: 8,
          //         ),
          //       ],
          //     ),
          //   ),
          // )),),


          const CustomText(
            text: AppStrings.countryName,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 16,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            hintText: 'Enter your country name',
            textEditingController:_uploadController.countryNameTextCtrl,

            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
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
            text: AppStrings.fabric,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 16,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            hintText: 'cotton',
            textEditingController:_uploadController.fabricTextCtrl,
            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
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
            text: AppStrings.material,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 16,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            hintText: 'silk',
            textEditingController:_uploadController.materialTextCtrl,

            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
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
            text: AppStrings.care,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 16,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            hintText: 'Normal Wash',
            textEditingController:_uploadController.careTextCtrl,

            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
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
            text: 'Instagram username',
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 32,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            hintText: 'Enter your instagram username',
            textEditingController:_uploadController.instagramLinkTextCtrl,


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
            text: 'Tiktok username',
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 32,
            bottom: 8,
          ),
          CustomTextField(
            textAlign: TextAlign.start,
            hintText: "Enter your tiktok username",
            textEditingController:_uploadController.tiktokLinkTextCtrl,
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
            text: AppStrings.occasionsCategory,
            color: AppColors.black_100,
            fontWeight: FontWeight.w500,
            top: 24,
            bottom: 8,
          ),
          GridView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: _uploadController.categoryList.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 0,
                  mainAxisExtent: 50),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => setState(() {
                  _uploadController.selectCategoryIndex.value = index;
                }),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                          Border.all(color: AppColors.purple, width: 1),
                          color: index == _uploadController.selectCategoryIndex.value
                              ? AppColors.purple
                              : AppColors.white,
                        ),
                      ),
                      Flexible(
                        child: CustomText(
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          text: _uploadController.categoryList.value[index].name??"",
                          color: AppColors.black_100,
                          fontWeight: FontWeight.w500,
                          left: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          const CustomText(
            text: AppStrings.description,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 24,
            bottom: 8,
          ),
          CustomTextField(
            maxLines: 3,
            textEditingController:_uploadController.descriptionTextCtrl,
            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
              }
              return null;
            },
            textAlign: TextAlign.start,
            hintText: 'About your product',
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
          const SizedBox(height: 20,),
          Obx(()=>
             NewCustomButton(onTap:(){
              if(formKey.currentState!.validate()){
            _uploadController.uploadVideo(_uploadController.videoFilePath.value.isEmpty?widget.path:_uploadController.videoFilePath.value);

              }

            }, text:AppStrings.upload,loading:_uploadController.uploadLoading.value,),
          )
        ],
      ),
    );
  }
}
