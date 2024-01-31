import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/style.dart';

class NewCustomButton extends StatelessWidget {
  NewCustomButton({super.key,this.color, this.padding =EdgeInsets.zero, required this.onTap,required this.text ,this.loading=false,this.width,this.height});
  Function() onTap;
  String text;
  bool loading;
  double? height;
  double? width;
  Color? color;
  EdgeInsetsGeometry padding;


  @override

  Widget build(BuildContext context) {
    return  Padding(
      padding: padding,
      child: ElevatedButton(onPressed:loading? (){}:onTap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)
            ),
            backgroundColor: color??AppColors.purple,
            minimumSize:Size(width??Get.width, height??56.h),

          ),
          child:loading?  SizedBox(
            height: 20.h,
            width: 20.h,
            child: const CircularProgressIndicator(color: Colors.white,),
          ):Text(text,style:AppStyles.h4(fontWeight: FontWeight.w600,color:Colors.white),)),
    );
  }
}