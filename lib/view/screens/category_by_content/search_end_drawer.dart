import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/screens/category_by_content/Controller/category_by_content_controller.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';

class SearchEndDrawer extends StatefulWidget {

  const SearchEndDrawer({super.key,required this.categoryName});
  final String categoryName;
  @override
  State<SearchEndDrawer> createState() => _SearchEndDrawerState();
}

class _SearchEndDrawerState extends State<SearchEndDrawer> {

  final _categoryContentController = Get.put(CategoryByContentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFF818181)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child:  const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.black_100,
                  size: 20,
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1, width: MediaQuery.of(context).size.width,
                    color: AppColors.purple,
                  ),
                  const SizedBox(height: 16),
                 Wrap(
                   children:List.generate(_categoryContentController.genderList.length, (index) =>  GestureDetector(
                     onTap: () => setState(() {
                       _categoryContentController.selectGender.value = _categoryContentController.genderList[index];
                     }),
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                       margin:EdgeInsets.only(right: 10.w),
                       decoration: ShapeDecoration(
                         color: _categoryContentController.genderList[index] == _categoryContentController.selectGender.value ? AppColors.purple : AppColors.white,
                         shape: RoundedRectangleBorder(
                           side: BorderSide(width: 1, color:_categoryContentController.genderList[index] == _categoryContentController.selectGender.value ? AppColors.purple :  AppColors.purple ),
                           borderRadius: BorderRadius.circular(4),
                         ),
                       ),
                       child: Text(
                         _categoryContentController.genderList[index],
                         textAlign: TextAlign.center,
                         style: GoogleFonts.raleway(
                           color: _categoryContentController.genderList[index] == _categoryContentController.selectGender.value ? AppColors.white : AppColors.purple,
                           fontSize: 12,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                     ),
                   )),
                 ),


                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          NewCustomButton(onTap:(){
          _categoryContentController.fastLoad(widget.categoryName,false);
          Get.back();

          }, text: AppStrings.apply),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
