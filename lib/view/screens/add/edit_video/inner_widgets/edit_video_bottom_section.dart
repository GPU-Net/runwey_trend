import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import '../Controller/edit_product_controller.dart';

class EDitVideoBottomSection extends StatefulWidget {
  const EDitVideoBottomSection({super.key});

  @override
  State<EDitVideoBottomSection> createState() => _EDitVideoBottomSectionState();
}

class _EDitVideoBottomSectionState extends State<EDitVideoBottomSection> {
  final _editController = Get.put(EditVideoController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      ],
    );
  }
}
