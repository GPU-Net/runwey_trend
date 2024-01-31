import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import 'image/custom_image.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key,required this.onTap});
final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const CustomImage(imageSrc:AppImages.noInternetImage),
            SizedBox(height: 20.h,),
            Text("No internet!",style:TextStyle(fontWeight: FontWeight.w500,fontSize:16.sp),),
            SizedBox(height: 20.h,),
            ElevatedButton(onPressed:onTap,
              style:ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  minimumSize: Size(Get.width/1.6,40.h),
                  shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(34.r),
                        bottomLeft: Radius.circular(34.r),
                      )
                  )


              ), child:const Text("Try Again",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),


            )
          ],
        ),
      ),
    );
  }
}
