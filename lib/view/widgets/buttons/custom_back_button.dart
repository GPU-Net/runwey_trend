import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/utils/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key,this.color});
final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed:(){
      Get.back();
    }, icon:Icon(Icons.arrow_back_ios,size:18.h,color:color??AppColors.black_100,));
  }
}
