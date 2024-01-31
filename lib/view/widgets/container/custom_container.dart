import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
        this.height,
        this.marginTop = 20,
        this.paddingVertical = 24,
        this.paddingHorizontal = 20,
        this.radiusTopLeft = 16,
        this.radiusTopRight = 16,
        this.width = double.infinity,
        required this.child, required decoration});

  final double radiusTopLeft;
  final double radiusTopRight;
  final double paddingVertical;
  final double paddingHorizontal;
  final double width;
  final double? height;
  final Widget child;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: marginTop),
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusTopLeft),
          topRight: Radius.circular(radiusTopRight),
        ),
      ),
      child: child,
    );
  }
}