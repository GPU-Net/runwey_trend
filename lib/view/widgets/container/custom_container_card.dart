import 'package:flutter/material.dart';

class CustomContainerCard extends StatelessWidget {
  const CustomContainerCard(
      {super.key,
        this.marginBottom=0,
        this.paddingTop=0,
        this.paddingLeft=0,
        this.paddingRight=0,
        this.marginLeft=0,
        this.marginRight=0,
        this.marginTop=0,
        this.paddingBottom=0,
        required this.content,
        this.onTap,
        this.decoration,
        this.width,
        this.height,
        this.alignment
      });
  final Widget? content;
  final double paddingBottom;
  final double paddingTop;
  final double paddingLeft;
  final double paddingRight;
  final double marginBottom;
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final double ? width;
  final double ? height;
  final VoidCallback ?onTap;
  final Decoration ? decoration;
  final Alignment ?alignment;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        padding:  EdgeInsets.only(bottom: paddingBottom, top: paddingTop, left: paddingLeft, right: paddingRight),
        margin:  EdgeInsets.only(bottom: marginBottom, top: marginTop, left: marginLeft, right: marginRight),
        width: width,
        height: height,
        decoration: decoration,
        child:content,
      ),
    );
  }
}
