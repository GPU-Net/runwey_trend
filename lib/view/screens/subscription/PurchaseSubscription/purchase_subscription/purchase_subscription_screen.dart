import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/subscription/PurchaseSubscription/Controller/purchase_subscription_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import '../../../../widgets/buttons/custom_back_button.dart';
import '../purchase_subscription_details/purchase_subscription_details_screen.dart';

class PurchaseSubscriptionScreen extends StatefulWidget {
  const PurchaseSubscriptionScreen({super.key});

  @override
  State<PurchaseSubscriptionScreen> createState() =>
      _PurchaseSubscriptionScreenState();
}

class _PurchaseSubscriptionScreenState
    extends State<PurchaseSubscriptionScreen> {

  final _purchaseController = Get.put(PurchaseSubscriptionController());

  @override
  void initState() {
    DeviceUtils.authUtils();
    _purchaseController.getSubscription();
    super.initState();
  }
  List<String> tabList = ["Regular", "Standard", "Premium"];
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
          appBar: CustomAppBar(
              appBarContent: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(),
                  Text(
                    AppStrings.purchaseSubscription,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: AppColors.black_100,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox()
                ],
              )),
          body:Obx((){
            switch(_purchaseController.rxRequestStatus.value){
              case Status.loading:
                return const CustomLoader();
              case Status.internetError:
                return NoInternetScreen(onTap:(){
                  _purchaseController.getSubscription();
                });
              case Status.error:
                return GeneralErrorScreen(onTap:(){
                  _purchaseController.getSubscription();
                });
              case Status.completed:
                return  LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 20, vertical: 24),
                          child: Obx(()=>
                             Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side:  BorderSide(
                                      width: 1, color: colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.mainColor)),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      _purchaseController.subscriptionList.length,
                                          (index) {
                                            int colorValue = int.parse(_purchaseController.subscriptionList[index].package.mainColor.replaceAll('#', '0xFF'),);
                                         //   int colorValue = int.parse("#6611E".replaceAll('#', '0xFF'));

                                            return  Flexible(
                                        child: GestureDetector(
                                          onTap: (){
                                            _purchaseController.selectSubscription.value=index;
                                          },

                                          child: Container(
                                            padding:  const EdgeInsets.all(14),
                                            width:double.maxFinite,
                                            decoration: ShapeDecoration(
                                              color: index == _purchaseController.selectSubscription.value
                                                  ?Color(colorValue)
                                                  : Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8)),
                                            ),
                                            child: Text(
                                              _purchaseController.subscriptionList[index].package.name??"",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(

                                                color: index == _purchaseController.selectSubscription.value
                                                    ? Colors.white
                                                    : colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.mainColor),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                      }
    )
    ),
                            ),
                          ),
                        ),
                        Obx((){
                          var packageData=_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package;
                          return Flexible(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 34),
                              child: Container(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color:colorConverter(packageData.mainColor), width: 1),
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 160, width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.mainColor),
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16))
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin:
                                            const EdgeInsets.only(top: 16),
                                            padding: const EdgeInsets.all(18),
                                            decoration: const ShapeDecoration(
                                              color: Colors.white,
                                              shape: OvalBorder(),
                                              shadows: [
                                                BoxShadow(
                                                  color: Color(0x3F000000),
                                                  blurRadius: 15,
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child:CustomImage(
                                              imageSrc: AppIcons.crown,
                                              imageColor: colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.mainColor),

                                              size: 28,
                                            ),
                                          ),
                                           CustomText(
                                            text: packageData.name??"",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.white,
                                            top: 8,
                                            bottom: 4,
                                          ),
                                           CustomText(
                                            text:packageData.name =="Regular"?"Free":
                                            "\$${packageData.price}/${packageData.validity} Months", //$1.99/6 Months
                                            fontSize: 12,
                                            color: AppColors.white,
                                            bottom: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 45),
                                     Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 24,),
                                            CustomImage(imageSrc: AppIcons.regularSub, size: 16,imageColor: colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.mainColor),),
                                            CustomText(
                                              text:packageData.name =="Regular"? 'Google Advertisement':"Advertisement Free",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.mainColor),
                                              left: 8,
                                            )
                                          ],
                                        ),

                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    if(packageData.name !="Regular")
                                    CustomButton(onPressed: (){
                                     Get.to( PurchaseStandardPlanScreen(subscriptionModel:_purchaseController.subscriptionList[_purchaseController.selectSubscription.value],));
                                    }, titleText: 'Buy Now',titleSize: 14,titleWeight: FontWeight.w600,buttonBgColor:colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.mainColor),leftPadding: 27,rightPadding: 27,buttonHeight: 36,),

                                    const SizedBox(height: 45),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            bottom: 18,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 78,
                                              decoration:  BoxDecoration(
                                                  color:colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.opacity1),
                                                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24))
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 78,
                                              decoration:  BoxDecoration(
                                                  color: colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.opacity2),
                                                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24))
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 78,
                                            decoration:  BoxDecoration(
                                                color: colorConverter(_purchaseController.subscriptionList[_purchaseController.selectSubscription.value].package.opacity3),
                                                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24))
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                            //     : selectedTabIndex == 1
                            //     ? SingleChildScrollView(
                            //   padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 34),
                            //   child: Container(
                            //     padding: EdgeInsets.zero,
                            //     alignment: Alignment.center,
                            //     width: MediaQuery.of(context).size.width,
                            //     decoration: BoxDecoration(
                            //         color: Colors.transparent,
                            //         border: Border.all(color: AppColors.green_100, width: 1),
                            //         borderRadius: BorderRadius.circular(16)
                            //     ),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Container(
                            //           height: 160, width: MediaQuery.of(context).size.width,
                            //           alignment: Alignment.center,
                            //           decoration: const BoxDecoration(
                            //               color: AppColors.green_100,
                            //               borderRadius: BorderRadius.vertical(top: Radius.circular(16))
                            //           ),
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             crossAxisAlignment: CrossAxisAlignment.center,
                            //             children: [
                            //               Container(
                            //                 margin:
                            //                 const EdgeInsets.only(top: 16),
                            //                 padding: const EdgeInsets.all(18),
                            //                 decoration: const ShapeDecoration(
                            //                   color: Colors.white,
                            //                   shape: OvalBorder(),
                            //                   shadows: [
                            //                     BoxShadow(
                            //                       color: Color(0x3F000000),
                            //                       blurRadius: 15,
                            //                       offset: Offset(0, 0),
                            //                       spreadRadius: 0,
                            //                     )
                            //                   ],
                            //                 ),
                            //                 child: const CustomImage(
                            //                   imageSrc: AppIcons.crown,
                            //                   size: 28,
                            //                   imageColor: AppColors.green_100,
                            //                 ),
                            //               ),
                            //               const CustomText(
                            //                 text: AppStrings.standard,
                            //                 fontSize: 18,
                            //                 fontWeight: FontWeight.w500,
                            //                 color: AppColors.white,
                            //                 top: 8,
                            //                 bottom: 4,
                            //               ),
                            //               const CustomText(
                            //                 text: '\$ ${'1.99/6 Months'}',
                            //                 fontSize: 12,
                            //                 color: AppColors.white,
                            //                 bottom: 16,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         const SizedBox(height: 45),
                            //         const Row(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           children: [
                            //
                            //             CustomImage(imageSrc: AppIcons.regularSub, size: 16,imageColor: AppColors.green_100,),
                            //             CustomText(
                            //               text: 'Advertisement Free',
                            //               fontWeight: FontWeight.w500,
                            //               fontSize: 14,
                            //               color: AppColors.green_100,
                            //               left: 8,
                            //             )
                            //           ],
                            //         ),
                            //         const SizedBox(height: 24),
                            //         CustomButton(onPressed: (){
                            //           Get.toNamed(AppRoute.purchaseStandardPlanScreen);
                            //         }, titleText: 'Buy Now',buttonBgColor: AppColors.green_100,leftPadding: 27,rightPadding: 27,buttonHeight: 36,),
                            //         const SizedBox(height: 44),
                            //         FittedBox(
                            //           fit: BoxFit.contain,
                            //           child: Stack(
                            //             clipBehavior: Clip.none,
                            //             children: [
                            //               Positioned(
                            //                 bottom: 18,
                            //                 child: Container(
                            //                   width: MediaQuery.of(context).size.width,
                            //                   height: 60,
                            //                   decoration: const BoxDecoration(
                            //                       color: AppColors.green_60,
                            //                       borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))
                            //                   ),
                            //                 ),
                            //               ),
                            //               Positioned(
                            //                 bottom: 10,
                            //                 child: Container(
                            //                   width: MediaQuery.of(context).size.width,
                            //                   height: 60,
                            //                   decoration: const BoxDecoration(
                            //                       color: AppColors.green_40,
                            //                       borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))
                            //                   ),
                            //                 ),
                            //               ),
                            //               Container(
                            //                 width: MediaQuery.of(context).size.width,
                            //                 height: 60,
                            //                 decoration: const BoxDecoration(
                            //                     color: AppColors.green_20,
                            //                     borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                            //     : selectedTabIndex == 2
                            //     ? SingleChildScrollView(
                            //   padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 34),
                            //   child: Container(
                            //     padding: EdgeInsets.zero,
                            //     alignment: Alignment.center,
                            //     width: MediaQuery.of(context).size.width,
                            //     decoration: BoxDecoration(
                            //         color: Colors.transparent,
                            //         border: Border.all(color: AppColors.purple, width: 1),
                            //         borderRadius: BorderRadius.circular(16)
                            //     ),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Container(
                            //           height: 160, width: MediaQuery.of(context).size.width,
                            //           alignment: Alignment.center,
                            //           decoration: const BoxDecoration(
                            //               color: AppColors.purple,
                            //               borderRadius: BorderRadius.vertical(top: Radius.circular(16))
                            //           ),
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             crossAxisAlignment: CrossAxisAlignment.center,
                            //             children: [
                            //               Container(
                            //                 margin:
                            //                 const EdgeInsets.only(top: 16),
                            //                 padding: const EdgeInsets.all(18),
                            //                 decoration: const ShapeDecoration(
                            //                   color: Colors.white,
                            //                   shape: OvalBorder(),
                            //                   shadows: [
                            //                     BoxShadow(
                            //                       color: Color(0x3F000000),
                            //                       blurRadius: 15,
                            //                       offset: Offset(0, 0),
                            //                       spreadRadius: 0,
                            //                     )
                            //                   ],
                            //                 ),
                            //                 child: const CustomImage(
                            //                   imageSrc: AppIcons.crown,
                            //                   size: 28,
                            //                   imageColor: AppColors.purple,
                            //                 ),
                            //               ),
                            //               const CustomText(
                            //                 text: AppStrings.premium,
                            //                 fontSize: 18,
                            //                 fontWeight: FontWeight.w500,
                            //                 color: AppColors.white,
                            //                 top: 8,
                            //                 bottom: 4,
                            //               ),
                            //               const CustomText(
                            //                 text: '\$ ${'1.99/6 Months'}',
                            //                 fontSize: 12,
                            //                 color: AppColors.white,
                            //                 bottom: 16,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         const SizedBox(height: 45),
                            //         const Row(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           children: [
                            //
                            //             CustomImage(imageSrc: AppIcons.regularSub, size: 16,imageColor: AppColors.purple,),
                            //             CustomText(
                            //               text: 'Advertisement Free',
                            //               fontWeight: FontWeight.w500,
                            //               fontSize: 14,
                            //               color: AppColors.purple,
                            //               left: 8,
                            //             )
                            //           ],
                            //         ),
                            //         const SizedBox(height: 24),
                            //         CustomButton(onPressed: (){
                            //           Get.toNamed(AppRoute.purchasePremiumPlanScreen);
                            //         }, titleText: 'Buy Now',buttonBgColor: AppColors.purple,leftPadding: 27,rightPadding: 27,buttonHeight: 36,),
                            //         const SizedBox(height: 44),
                            //         FittedBox(
                            //           fit: BoxFit.contain,
                            //           child: Stack(
                            //             clipBehavior: Clip.none,
                            //             children: [
                            //               Positioned(
                            //                 bottom: 18,
                            //                 child: Container(
                            //                   width: MediaQuery.of(context).size.width,
                            //                   height: 60,
                            //                   decoration: const BoxDecoration(
                            //                       color: AppColors.purple_60,
                            //                       borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))
                            //                   ),
                            //                 ),
                            //               ),
                            //               Positioned(
                            //                 bottom: 10,
                            //                 child: Container(
                            //                   width: MediaQuery.of(context).size.width,
                            //                   height: 60,
                            //                   decoration: const BoxDecoration(
                            //                       color: AppColors.purple_40,
                            //                       borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))
                            //                   ),
                            //                 ),
                            //               ),
                            //               Container(
                            //                 width: MediaQuery.of(context).size.width,
                            //                 height: 60,
                            //                 decoration: const BoxDecoration(
                            //                     color: AppColors.purple_20,
                            //                     borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                            //     : const SizedBox(),
                          );}
                        )
                      ],
                    );
                  },
                );
            }


          })



      ),
    );
  }

  Color colorConverter(String colorCode) => Color(int.parse(colorCode.replaceAll('#', '0xFF'),));

}