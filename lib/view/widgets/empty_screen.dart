import 'package:flutter/material.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(imageSrc:AppImages.emptyImage),
          SizedBox(height: 10,),
          Text("No data found",style:TextStyle(fontSize:18,color:Colors.grey ),)
        ],
      ),
    );
  }
}
