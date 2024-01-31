import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import '../Controller/edit_product_controller.dart';

class EditVideoMiddleSection extends StatefulWidget {
  const EditVideoMiddleSection({super.key});

  @override
  State<EditVideoMiddleSection> createState() => _EditVideoMiddleSectionState();
}

class _EditVideoMiddleSectionState extends State<EditVideoMiddleSection> {
  final _editController = Get.put(EditVideoController());

  // int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editController.formKey,
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
            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
              }
              return null;
            },
            textAlign: TextAlign.start,
            textEditingController: _editController.titleTextCtrl,
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
                itemCount:  _editController.sizeList.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.width,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 0,
                    mainAxisExtent: 40
                ),
                itemBuilder: (context, index) => Obx(()=>
                   GestureDetector(
                    onTap: (){
                      _editController.selectSize.value=_editController.sizeList[index];
                    },
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
                              color: _editController.selectSize.value == _editController.sizeList[index]
                                  ? AppColors.purple
                                  : AppColors.white,
                            ),
                          ),
                          CustomText(
                            text: _editController.sizeList[index],
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            left: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),

          const CustomText(
            text: AppStrings.countryName,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 16,
            bottom: 8,
          ),
          CustomTextField(
            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
              }
              return null;
            },
            textAlign: TextAlign.start,
            hintText: 'Enter your country name',
            textEditingController: _editController.countryNameTextCtrl,
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
            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
              }
              return null;
            },
            textAlign: TextAlign.start,
            textEditingController: _editController.fabricTextCtrl,
            hintText: 'cotton',
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
            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
              }
              return null;
            },
            textAlign: TextAlign.start,
            textEditingController: _editController.materialTextCtrl,
            hintText: 'silk',
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
            validator:(value){
              if(value!.isEmpty){
                return "Field is empty!";
              }
              return null;
            },
            textAlign: TextAlign.start,
            textEditingController: _editController.careTextCtrl,
            hintText: 'Normal Wash',
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
            textEditingController: _editController.instagramLinkTextCtrl,
            hintText: 'Enter your instagram username',
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
            hintText: 'Enter your tiktok username',
            textEditingController: _editController.tiktokLinkTextCtrl,
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
          Obx(()=>
              GridView.builder(
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: _editController.categoryList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 0,
                      mainAxisExtent: 50),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      _editController.selectCategoryIndex.value=index;
                    },
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
                          Obx(()=>
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                  Border.all(color: AppColors.purple, width: 1),
                                  color: index == _editController.selectCategoryIndex.value
                                      ? AppColors.purple
                                      : AppColors.white,
                                ),
                              ),
                          ),
                          Flexible(
                            child: CustomText(
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              text: _editController.categoryList[index].name??"",
                              color: AppColors.black_100,
                              fontWeight: FontWeight.w500,
                              left: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
          ),
          const CustomText(
            text: AppStrings.description,
            color: AppColors.black_100,
            fontWeight: FontWeight.w400,
            top: 24,
            bottom: 8,
          ),
          CustomTextField(
            maxLines: 3,
            textEditingController: _editController.descriptionTextCtrl,
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
        ],
      ),
    );
  }
}
