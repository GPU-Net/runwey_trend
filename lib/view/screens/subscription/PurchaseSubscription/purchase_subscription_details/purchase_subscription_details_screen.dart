import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/model/subscription_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../../widgets/buttons/custom_back_button.dart';
import '../../payment/payment_screen.dart';

class PurchaseStandardPlanScreen extends StatefulWidget {
  const PurchaseStandardPlanScreen(
      {super.key, required this.subscriptionModel});

  final SubscriptionModel subscriptionModel;

  @override
  State<PurchaseStandardPlanScreen> createState() =>
      _PurchaseStandardPlanScreenState();
}

class _PurchaseStandardPlanScreenState
    extends State<PurchaseStandardPlanScreen> {
  @override
  void initState() {
    DeviceUtils.authUtils();
    super.initState();
  }

  bool isChecked = true;
  bool isCheck = true;
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
                Expanded(
                  child: CustomText(
                    text: '${widget.subscriptionModel.name} Plan',
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_100,
                  ),
                ),
                const SizedBox()
              ],
            )),
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CustomText(
                              text:
                                  'Purchase ${widget.subscriptionModel.name} Plan',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black_100,
                              bottom: 24,
                              top: 20,
                            ),
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 34),
                            child: Container(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: colorConverter(widget
                                          .subscriptionModel.package.mainColor),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 160,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: colorConverter(widget
                                            .subscriptionModel
                                            .package
                                            .mainColor),
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          child: CustomImage(
                                            imageSrc: AppIcons.crown,
                                            size: 28,
                                            imageColor: colorConverter(widget
                                                .subscriptionModel
                                                .package
                                                .mainColor),
                                          ),
                                        ),
                                        const CustomText(
                                          text: AppStrings.standard,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.white,
                                          top: 8,
                                          bottom: 4,
                                        ),
                                        CustomText(
                                          text:
                                              "\$${widget.subscriptionModel.package.price}/${widget.subscriptionModel.package.validity} Months",
                                          fontSize: 12,
                                          color: AppColors.white,
                                          bottom: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 45),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomImage(
                                        imageSrc: AppIcons.regularSub,
                                        size: 16,
                                        imageColor: colorConverter(widget
                                            .subscriptionModel
                                            .package
                                            .mainColor),
                                      ),
                                      CustomText(
                                        text: 'Advertisement Free',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: colorConverter(widget
                                            .subscriptionModel
                                            .package
                                            .mainColor),
                                        left: 8,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          bottom: 18,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: colorConverter(widget
                                                    .subscriptionModel
                                                    .package
                                                    .opacity1),
                                                borderRadius:
                                                    const BorderRadius.vertical(
                                                        bottom: Radius.circular(
                                                            30))),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: colorConverter(widget
                                                    .subscriptionModel
                                                    .package
                                                    .opacity2),
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        bottom: Radius.circular(
                                                            30))),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: colorConverter(widget
                                                  .subscriptionModel
                                                  .package
                                                  .opacity3),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(30))),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(
                              text: 'Payment Method',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black_100,
                              bottom: 8,
                              top: 24,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.purple_20, width: 1)),
                            child: Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: const BoxDecoration(
                                      color: AppColors.purple,
                                      shape: BoxShape.circle),
                                ),
                                const CustomText(
                                  text: AppStrings.creditCard,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_100,
                                  left: 16,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
            bottomNavigationBar: BottomNavButton(
              buttonText: AppStrings.proceedToPayment,
              onTap: () {
             Get.to(PaymentScreen(subscriptionModel:widget.subscriptionModel,));
              },
            )));
  }

  Color colorConverter(String colorCode) => Color(int.parse(
        colorCode.replaceAll('#', '0xFF'),
      ));
}
