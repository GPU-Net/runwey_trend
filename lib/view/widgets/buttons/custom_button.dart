
import 'package:flutter/material.dart';

import '../text/custom_text.dart';
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String titleText;
  final Color titleColor;
  final Color buttonBgColor;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double ?buttonHeight;
  final double  topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final double ?buttonWidth;
  final double borderWidth;
  final TextAlign textAlign;
  final Color buttonBorderColor;
  final double ?elevation;
  const CustomButton(
      {
        super.key,
        this.textAlign = TextAlign.center,
        this.buttonBorderColor = Colors.transparent,
        required this.onPressed,
        required this.titleText,
        this.titleColor = Colors.white,
        this.buttonBgColor = Colors.white,
        this.titleSize = 18,
        this.buttonRadius = 8,
        this.titleWeight = FontWeight.w600,
        this.buttonHeight = 56,
        this.buttonWidth,
        this.elevation,
        this.topPadding =0,
        this.bottomPadding=0,
        this.leftPadding=0,
        this.rightPadding=0,
        this.borderWidth =0,
      });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor:buttonBgColor,
            padding: EdgeInsetsDirectional.only(top: topPadding,bottom: bottomPadding,start: leftPadding,end: rightPadding),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
                side: BorderSide(color: buttonBorderColor, width: borderWidth)
            )
        ),
        child: CustomText(
          text: titleText,
          textAlign: textAlign,
          fontSize: titleSize,
          fontWeight: titleWeight,
          color: titleColor,
        ),
      ),
    );
  }
}