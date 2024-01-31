import 'package:flutter/cupertino.dart';
import 'package:runwey_trend/model/content_details_model.dart';
import 'package:runwey_trend/model/content_model.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class ProductDetailsSection extends StatefulWidget {
  const ProductDetailsSection({super.key,required this.contentDetailsModel});
final ContentDetailsModel contentDetailsModel;
  @override
  State<ProductDetailsSection> createState() => _ProductDetailsSectionState();
}

class _ProductDetailsSectionState extends State<ProductDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          top: 24,
          text:AppStrings.productDetails,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          bottom: 16,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: AppStrings.countryName,
                ),
                CustomText(
                  text: widget.contentDetailsModel.attributes!.video!.countryName!,
                )
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  text: AppStrings.size,
                ),
                CustomText(
                  text: widget.contentDetailsModel.attributes!.video!.size!,
                )
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  text: AppStrings.fabric,
                ),
                CustomText(
                  text: widget.contentDetailsModel.attributes!.video!.fabric??"",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                )
              ],
            ),
            SizedBox(height: 8,),
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
                  text: widget.contentDetailsModel.attributes!.video!.material??"",
                )
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  text: AppStrings.care,
                ),
                CustomText(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text: widget.contentDetailsModel.attributes!.video!.care??"",
                )
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  text: AppStrings.occasionsCategory,
                ),
                CustomText(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text: widget.contentDetailsModel.attributes!.video!.occassionCategory??"",
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}