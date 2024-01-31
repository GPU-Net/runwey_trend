import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';

class CustomSearchField extends StatelessWidget {

  const CustomSearchField({super.key,this.onChanged, required this.hint,this.textEditingController,this.suffixIcon,this.prefixIcon});
  final String hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? textEditingController;
  final Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.black_10,
      controller: textEditingController,
      onChanged:onChanged,
      style: GoogleFonts.montserrat(color: AppColors.black_100, fontSize: 14, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          contentPadding:EdgeInsets.symmetric(horizontal: 15.w),
          hintText: hint,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: GoogleFonts.montserrat(
            color: AppColors.black_40,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border:buildOutlineInputBorder(),
          enabledBorder: buildOutlineInputBorder(),
          disabledBorder: buildOutlineInputBorder(),
          focusedBorder:buildOutlineInputBorder(),
          errorBorder: buildOutlineInputBorder()
      ),
    );
  }

   buildOutlineInputBorder() {
    return OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1
          ),
          borderRadius: BorderRadius.circular(8.r)
        );
  }
}