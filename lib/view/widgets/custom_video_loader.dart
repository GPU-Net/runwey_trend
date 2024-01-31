import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:runwey_trend/utils/app_colors.dart';

class CustomVideoLoader extends StatelessWidget {
  const CustomVideoLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitRing(
        color: AppColors.purple,
        size: 60.0,lineWidth:4,
      ),
    );
  }
}