import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomBackButton extends StatelessWidget {
   CustomBackButton({
    super.key,
    this.color
  });
  Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed:(){
      Get.back();
    }, icon: Icon(Icons.arrow_back_ios,size:18,color:color,));
  }
}