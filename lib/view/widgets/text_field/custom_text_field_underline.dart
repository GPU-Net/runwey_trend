// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class CustomTextFieldUnderline extends StatefulWidget {
//   const CustomTextFieldUnderline({
//     this.textEditingController,
//     this.focusNode,
//     this.keyboardType = TextInputType.text,
//     this.textInputAction = TextInputAction.next,
//     this.cursorColor = Colors.black,
//     this.inputTextStyle,
//     this.textAlignVertical = TextAlignVertical.center,
//     this.textAlign = TextAlign.start,
//     this.onChanged,
//     this.maxLines = 1,
//     this.validator,
//     this.hintText,
//     this.hintStyle,
//     this.fillColor = Colors.white,
//     this.suffixIcon,
//     this.suffixIconColor,
//     this.fieldBorderRadius = 0,
//     this.fieldBorderColor = Colors.white,
//     this.isPassword = false,
//     this.isPrefixIcon = false,
//     this.prefixIconColor,
//     this.prefixIconSrc,
//     this.readOnly = false,
//     this.borderWidth=1,
//     super.key
//   }
//       );
//
//   final TextEditingController? textEditingController;
//   final FocusNode? focusNode;
//   final TextInputType keyboardType;
//   final TextInputAction textInputAction;
//   final Color cursorColor;
//   final TextStyle? inputTextStyle;
//   final TextAlignVertical? textAlignVertical;
//   final TextAlign textAlign;
//   final int? maxLines;
//   final void Function(String)? onChanged;
//   final FormFieldValidator? validator;
//   final String? hintText;
//   final TextStyle? hintStyle;
//   final Color? fillColor;
//   final Color? suffixIconColor;
//   final String? suffixIcon;
//   final double fieldBorderRadius;
//   final double borderWidth;
//   final Color fieldBorderColor;
//   final bool isPassword;
//   final bool isPrefixIcon;
//   final String ?prefixIconSrc;
//   final Color ? prefixIconColor;
//   final bool readOnly;
//
//
//   @override
//   State<CustomTextFieldUnderline> createState() => _CustomTextFieldUnderlineState();
// }
//
// class _CustomTextFieldUnderlineState extends State<CustomTextFieldUnderline> {
//
//   bool obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       readOnly: widget.readOnly,
//       controller: widget.textEditingController,
//       focusNode: widget.focusNode,
//       keyboardType: widget.keyboardType,
//       textInputAction: widget.textInputAction,
//       cursorColor: widget.cursorColor,
//       style: widget.inputTextStyle,
//       onChanged: widget.onChanged,
//       maxLines: widget.maxLines,
//       obscureText:  widget.isPassword ? obscureText : false,
//       validator: widget.validator,
//       decoration: InputDecoration(
//         hintText: widget.hintText,
//         hintStyle: widget.hintStyle,
//         fillColor: widget.fillColor,
//         filled: true,
//         prefixIcon: widget.isPrefixIcon ? Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SvgPicture.asset(widget.prefixIconSrc ?? ""),
//         ) : null,
//         prefixIconColor: widget.prefixIconColor,
//         // suffixIcon: widget.isPassword ? GestureDetector(
//         //     onTap: toggle,
//         //     child: widget.suffixIcon
//         // ) : widget.suffixIcon,
//         suffixIcon:  widget.isPassword ? Padding(
//           padding: const EdgeInsets.all(14.0),
//           child: SvgPicture.asset(widget.suffixIcon ?? ''),
//         ) : null,
//         suffixIconColor: widget.suffixIconColor,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
//           borderSide: BorderSide(color: widget.fieldBorderColor, width: widget.borderWidth),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
//           borderSide: BorderSide(color: widget.fieldBorderColor, width: widget.borderWidth),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
//           borderSide: BorderSide(color: widget.fieldBorderColor, width:  widget.borderWidth),
//         ),
//       ),
//     );
//   }
//   void toggle() {
//     setState(() {
//       obscureText = !obscureText;
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';


class CustomTextFieldUnderline extends StatefulWidget {
  const CustomTextFieldUnderline({
    this.onFieldSubmitted,
    this.textEditingController,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.cursorColor = AppColors.purple,
    this.inputTextStyle,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.maxLines = 1,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.fillColor = AppColors.white,
    this.suffixIcon,
    this.suffixIconColor,
    this.fieldBorderRadius = 8,
    this.fieldBorderColor = AppColors.black_20,
    this.isPassword = false,
    this.isPrefixIcon = true,
    this.readOnly = false,
    super.key, this.prefixIconSrc
  });

  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FormFieldValidator? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? suffixIconColor;
  final Widget? suffixIcon;
  final Widget? prefixIconSrc;
  final double fieldBorderRadius;
  final Color fieldBorderColor;
  final bool isPassword;
  final bool isPrefixIcon;
  final bool readOnly;

  @override
  State<CustomTextFieldUnderline> createState() => _CustomTextFieldUnderlineState();
}

class _CustomTextFieldUnderlineState extends State<CustomTextFieldUnderline> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      onFieldSubmitted: widget.onFieldSubmitted,
      readOnly: widget.readOnly,
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      cursorColor: widget.cursorColor,
      style: widget.inputTextStyle,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      obscureText: widget.isPassword ? obscureText : false,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        fillColor: widget.fillColor,
        filled: true,

        suffixIcon: widget.isPassword ? GestureDetector(
          onTap: toggle,
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
            child: SvgPicture.asset(obscureText ? AppIcons.eyeOff : AppIcons.eyeOn,height: 18,width: 18),
          ),
        ) : widget.suffixIcon,
        suffixIconColor: widget.suffixIconColor,
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
            borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            ),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
            borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            ),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
            borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            ),
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
