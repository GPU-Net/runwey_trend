import 'package:flutter/material.dart';
import 'package:runwey_trend/model/content_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class ShowMyVideoBottomSection extends StatefulWidget {
  const ShowMyVideoBottomSection({super.key, required this.contentModel});
 final ContentModel contentModel;

  @override
  State<ShowMyVideoBottomSection> createState() => _ShowMyVideoBottomSectionState();
}

class _ShowMyVideoBottomSectionState extends State<ShowMyVideoBottomSection> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          top: 24,
          text: AppStrings.productDetails,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          bottom: 16,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: AppStrings.countryName,
                ),
                CustomText(
                  text:widget.contentModel.countryName??"",
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  text: AppStrings.size,
                ),
                CustomText(
                  text:widget.contentModel.size??"",
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  text: AppStrings.fabric,
                ),
                CustomText(
                  text:widget.contentModel.fabric??"",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  text: AppStrings.material,
                ),
                CustomText(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text: widget.contentModel.material??"",
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  text: AppStrings.care,
                ),
                CustomText(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text: widget.contentModel.care??"",
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  text: AppStrings.occasionsCategory,
                ),
                CustomText(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text: widget.contentModel.occassionCategory??"",
                )
              ],
            ),
          ],
        ),
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
          text: widget.contentModel.description??"",
          color: AppColors.black_100,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
