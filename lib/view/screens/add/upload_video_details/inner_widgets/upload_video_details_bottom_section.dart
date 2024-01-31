import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

class UploadVideoDetailsBottomSection extends StatefulWidget {
  const UploadVideoDetailsBottomSection({super.key});

  @override
  State<UploadVideoDetailsBottomSection> createState() =>
      _UploadVideoDetailsBottomSectionState();
}

class _UploadVideoDetailsBottomSectionState
    extends State<UploadVideoDetailsBottomSection> {
  List<String> occasionCategory = [
    'Church Wear',
    'Summer',
    'Party',
    'Picnic',
    'Work Party',
    'Wedding',
    '80’s Style',
    'Job',
    'Festivals',
    'Barbeque',
    'Concerts',
    'Funeral',
    'Beach',
    'Professional Function',
    'Dinner Date',
    'Winter Style',
  ];
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: AppStrings.occasionsCategory,
          color: AppColors.black_100,
          fontWeight: FontWeight.w500,
          top: 24,
          bottom: 8,
        ),
        GridView.builder(
            shrinkWrap: true,
            addAutomaticKeepAlives: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: occasionCategory.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width,
                crossAxisSpacing: 8,
                mainAxisSpacing: 0,
                mainAxisExtent: 50),
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () => setState(() {
                    selectedCategory = index;
                  }),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: AppColors.purple, width: 1),
                            color: index == selectedCategory
                                ? AppColors.purple
                                : AppColors.white,
                          ),
                        ),
                        Flexible(
                          child: CustomText(
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            text: occasionCategory[index],
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            left: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
        const CustomText(
          text: AppStrings.description,
          color: AppColors.black_100,
          fontWeight: FontWeight.w400,
          top: 24,
          bottom: 8,
        ),
        CustomTextField(
          maxLines: 3,
          textAlign: TextAlign.start,
          hintText: 'About your product',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black_40),
          inputTextStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.black_100),
          fieldBorderColor: AppColors.black_10,
          fieldBorderRadius: 8,
        ),
      ],
    );
  }
}
