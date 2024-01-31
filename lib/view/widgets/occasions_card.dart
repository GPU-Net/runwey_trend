import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/model/category_model.dart';
import 'package:runwey_trend/view/screens/category_by_content/summer_all_screen.dart';

import '../../core/route/app_route.dart';
import 'cache_nerwork_image.dart';

class OccasionsCard extends StatelessWidget {
  const OccasionsCard({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(SummerAllScreen(categoryName:categoryModel.name??""));
      },
      child: Stack(
        children: [
          // Background Image (Blurred)
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: CustomNetworkImage(
              imageUrl:categoryModel.categoryImage??"",
              borderRadius: BorderRadius.circular(12),
              height: 130.h,
              width: double.infinity,

            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX:0, sigmaY:0),
            child: Container(
              height: 130.h,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF5C5C5C).withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(categoryModel.name??"",style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize:18),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),// Adjust opacity as needed
            ),
          ),

        ],
      ),
    );
  }
}