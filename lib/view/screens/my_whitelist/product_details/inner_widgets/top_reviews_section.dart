import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/helper/date_formate_helper.dart';
import 'package:runwey_trend/model/content_details_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class WishListTopReviewsSection extends StatefulWidget {
  const WishListTopReviewsSection({super.key, required this.contentDetailsModel});
  final ContentDetailsModel contentDetailsModel;
  @override
  State<WishListTopReviewsSection> createState() => _WishListTopReviewsSectionState();
}

class _WishListTopReviewsSectionState extends State<WishListTopReviewsSection> {


  var itemCountToShow=5;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          top: 24,
          text: AppStrings.topReviews,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          bottom: 16,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount:widget.contentDetailsModel.attributes!.reviews!.length>5?itemCountToShow:widget.contentDetailsModel.attributes!.reviews!.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            var data =widget.contentDetailsModel.attributes!.reviews![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                     Expanded(
                       child: Text(data.userId!.fullName??"",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color:AppColors.black_100),maxLines: 2,overflow: TextOverflow.ellipsis,),
                     ),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemPadding: const EdgeInsets.only(right: 8),
                          itemSize: 14,
                          initialRating:data.ratings??0.0,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                         CustomText(
                          color: AppColors.black_100,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          text: data.ratings.toString(),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(data.message??"",style:  TextStyle(fontSize: 12.sp,color:AppColors.black_60),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    ),
                    const SizedBox(width: 30,),
                     CustomText(
                      color: AppColors.black_60,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,

                      text:DateFormatHelper.formatCustomDate(data.createdAt!),
                    )
                  ],
                ),
                // const SizedBox(height: 16,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const CustomText(
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //       text: AppStrings.smith,
                //     ),
                //     Row(
                //       children: [
                //         RatingBar.builder(
                //           itemPadding: const EdgeInsets.only(right: 8),
                //           itemSize: 14,
                //           initialRating: 4.5,
                //           minRating: 2,
                //           direction: Axis.horizontal,
                //           allowHalfRating: true,
                //           itemCount: 5,
                //           itemBuilder: (context, _) =>  Icon(
                //             Icons.star,
                //             color: Colors.amber,
                //           ),
                //           onRatingUpdate: (rating) {
                //             print(rating);
                //           },
                //         ),
                //         CustomText(
                //           color: AppColors.black_100,
                //           fontSize: 12,
                //           fontWeight: FontWeight.w400,
                //           text: "(4.5)",
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                // const SizedBox(height: 8,),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     CustomText(
                //       color:AppColors.black_60,
                //       fontSize: 12,
                //       fontWeight: FontWeight.w400,
                //       text: AppStrings.niceProduct,
                //     ),
                //     CustomText(
                //       color: AppColors.black_60,
                //       fontSize: 12,
                //       fontWeight: FontWeight.w400,
                //       text: "01 aug",
                //     )
                //   ],
                // ),
                // const SizedBox(height: 16,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     CustomText(
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //       text: AppStrings.smith,
                //     ),
                //     Row(
                //       children: [
                //         RatingBar.builder(
                //           itemPadding: const EdgeInsets.only(right: 8),
                //           itemSize: 14,
                //           initialRating: 4.5,
                //           minRating: 2,
                //           direction: Axis.horizontal,
                //           allowHalfRating: true,
                //           itemCount: 5,
                //           itemBuilder: (context, _) =>  Icon(
                //             Icons.star,
                //             color: Colors.amber,
                //           ),
                //           onRatingUpdate: (rating) {
                //             print(rating);
                //           },
                //         ),
                //         CustomText(
                //           color: AppColors.black_100,
                //           fontSize: 12,
                //           fontWeight: FontWeight.w400,
                //           text: "(4.5)",
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                // const SizedBox(height: 8,),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     CustomText(
                //       color:AppColors.black_60,
                //       fontSize: 12,
                //       fontWeight: FontWeight.w400,
                //       text: AppStrings.niceProduct,
                //     ),
                //     CustomText(
                //       color: AppColors.black_60,
                //       fontSize: 12,
                //       fontWeight: FontWeight.w400,
                //       text: "01 aug",
                //     )
                //   ],
                // ),
                // const SizedBox(height: 16,),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 16.h,
            );
          },
        ),
        if (itemCountToShow < widget.contentDetailsModel.attributes!.reviews!.length)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  // Show the next 5 items or remaining items if less than 5
                  if (itemCountToShow < widget.contentDetailsModel.attributes!.reviews!.length) {
                    var checkItem=widget.contentDetailsModel.attributes!.reviews!.length - itemCountToShow;
                    debugPrint(checkItem.toString());
                    if(checkItem>5){
                      itemCountToShow +=5;
                    }else{
                      itemCountToShow=widget.contentDetailsModel.attributes!.reviews!.length;
                    }

                  }
                });
              },
              child: Text('See More',style: TextStyle(fontSize:12.sp,color: AppColors.black_100,fontWeight: FontWeight.w600),),
            ),
          ),
      ],
    );
  }
}
