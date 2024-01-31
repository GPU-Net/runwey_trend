
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGradientButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText ;
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight ;

  const CustomGradientButton({super.key,
    required this.onTap,
    required this.buttonText,
     this.textColor=  Colors.white,
     this.textSize = 16,
     this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                   buttonText,
                  style: GoogleFonts.nunito(
                  color:textColor ,
                  fontSize:  textSize,
                  fontWeight: fontWeight ,
                ),
              )
            ),
          ),
        )
    );
  }
}
