import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../Controller/products_details_controller.dart';

class AlertDialogBoxe extends StatefulWidget {
  const AlertDialogBoxe({super.key});

  @override
  State<AlertDialogBoxe> createState() => _AlertDialogBoxeState();
}

class _AlertDialogBoxeState extends State<AlertDialogBoxe> {
  final _detailsController =Get.put(SimilarContentDetailsController());
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      titlePadding: const EdgeInsets.only(top: 16,bottom: 24),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      content: SingleChildScrollView(
        child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal:  16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CustomImage(
                          size: 100,
                          imageType: ImageType.png,
                          imageSrc: AppImages.successReview),
                    )

                  ],
                ),
              ),
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const CustomText(
                        text: AppStrings.giveUsRating,
                        color: AppColors.black_100,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 16,),
                      RatingBar.builder(
                        itemPadding: const EdgeInsets.only(right: 8),
                        itemSize: 30,
                        initialRating:_detailsController.rating.value,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemBuilder: (context, _) =>  const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                        _detailsController.rating.value=rating;
                        },
                      ),
                      const SizedBox(height: 32,),
                      TextFormField(
                      controller: _detailsController.feedbackController,
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_100

                        ),
                        validator: (value){
                        if(value!.isEmpty){
                          return "Field is empty";
                        }
                        return null;
                        },
                        maxLines: 3,
                        decoration: InputDecoration(
                            hintText: "Write your feedback........",
                            hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.black_20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:  const BorderSide(
                                color: AppColors.black_100,
                              ),
                            ),
                            focusedBorder:  const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.purple,
                                )
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.purple
                                )
                            )
                        ),
                      ),
                      const SizedBox(height: 14,),
                    Obx(()=>
                       NewCustomButton(onTap:(){
                         if(_formKey.currentState!.validate()){
                           _detailsController.feedBack(_detailsController.contentDetailsModel.value.attributes!.video!.id!);
                         }
                      }, text: "Submit",loading:_detailsController.ratingLoading.value,height: 35,width: 100,),
                    )
                    ],
                  ),
                ),
              )

            ]
        ),
      ),
    );
  }
}