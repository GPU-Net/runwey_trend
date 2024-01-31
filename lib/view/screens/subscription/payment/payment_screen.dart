import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/model/subscription_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/subscription/payment/Controller/payment_controller.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import 'inner_widgets/input_formatter.dart';
import 'inner_widgets/payment_standard_alert_box.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key,required this.subscriptionModel});
final SubscriptionModel subscriptionModel;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final _paymentController = Get.put(PaymentController());

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  void initState() {
    DeviceUtils.authUtils();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        body: LayoutBuilder(
      builder: (BuildContext context,BoxConstraints constraints){
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration:  BoxDecoration(
                color:colorConverter(widget.subscriptionModel.package.mainColor) ,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap:(){
                            Get.back();
                          },
                          child: const CustomImage(imageSrc: AppIcons.backIcon,imageColor: AppColors.white,size: 18,)),
                      const CustomText(
                        text: 'Payment',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      const SizedBox()
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: '\$ ${widget.subscriptionModel.package.price}',
                        fontSize: 44,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                      CustomText(
                        text: '${widget.subscriptionModel.package.validity} Months',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                        top: 8,
                      ),

                    ],
                  )
                ],
              ),
            ),
            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: AppStrings.cardNumber,
                        color: AppColors.black_100,
                        fontWeight: FontWeight.w500,
                        top: 20,
                        bottom: 8,
                      ),
                      CustomTextField(
                        textAlign: TextAlign.start,
                        hintText: AppStrings.enterCreditCardNumber,
                        textEditingController: _paymentController.cardCtrl,
                     keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your card number";
                          } else if (value.length < 16) {
                            return "Enter your valid card number";
                          }
                          return null;
                        },
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
                      const CustomText(
                        text: AppStrings.expireDate,
                        color: AppColors.black_100,
                        fontWeight: FontWeight.w500,
                        top: 16,
                        bottom: 8,
                      ),
                      CustomTextField(
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        textEditingController: _paymentController.expireCtrl,
                        hintText: 'MM/YY',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardMonthInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your expiry date";
                          } else if (value.length < 4) {
                            return "Enter your valid expiry date";
                          }
                          return null;
                        },
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
                      const CustomText(
                        text: 'CVV',
                        color: AppColors.black_100,
                        fontWeight: FontWeight.w500,
                        top: 16,
                        bottom: 8,
                      ),
                      CustomTextField(
                        textAlign: TextAlign.start,
                        isPassword: true,
                        hintText: 'CVV',
                        textEditingController: _paymentController.cvvCtrl,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your  cvv";
                          } else if (value.length < 3) {
                            return "Enter your valid cvv ";
                          }
                          return null;
                        },
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

                      SizedBox(height: 30.h,),
                      Obx(()=>
                         NewCustomButton(text: 'Proceed to payment',
                          loading: _paymentController.isLoading.value,
                          onTap: () {
                          if(_formKey.currentState!.validate()){
                            _paymentController.tokenizeCard(widget.subscriptionModel);
                          }
                        },),
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        );
      },
        ),

      ),
    );
  }
  Color colorConverter(String colorCode) => Color(int.parse(
    colorCode.replaceAll('#', '0xFF'),
  ));
}
