import 'package:flutter/cupertino.dart';
import 'package:runwey_trend/model/content_details_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key,required this.contentDetailsModel});
final ContentDetailsModel contentDetailsModel;
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          top: 24,
          text:AppStrings.description,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          bottom: 16,
        ),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 10,
          text: contentDetailsModel.attributes!.video!.description??"",
          color: AppColors.black_100,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}