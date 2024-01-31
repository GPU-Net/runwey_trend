import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/add/Controller/question_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field_underline.dart';

import '../../../widgets/buttons/custom_back_button.dart';
import '../../../widgets/custom_loader.dart';
import 'inner_widgets/custom_alert_box.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  final _questionController =Get.put(QuestionController());
  @override
  void initState() {
    DeviceUtils.authUtils();
    _questionController.getQuestion();
    super.initState();
  }
  @override
  void dispose() {
    _questionController.controllerList.clear();
    super.dispose();
  }
  final GlobalKey<FormState> _key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(),
              // GestureDetector(
              //   onTap:(){
              //     Get.back();
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: const CustomImage(
              //       imageSrc: AppIcons.backIcon,
              //       size: 18,
              //     ),
              //   ),
              // ),
              Expanded(
                child: CustomText(
                  text: AppStrings.questionnaire,
                  fontSize: 18,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_100,
                ),
              ),
              SizedBox()
            ],
          )),
      body: LayoutBuilder(
        builder: (BuildContext content,BoxConstraints constraints){
          return  Obx(()=> _questionController.loading.value?const CustomLoader():
             SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                     CustomText(
                      textAlign: TextAlign.start,
                      text: AppStrings.answerTheFollowing,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.black_100,
                      maxLines: 5,
                      bottom: 44.h,
                    ),
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder:(context,index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 6,right: 6,top: 8,bottom: 6),
                                decoration: const BoxDecoration(
                                    color: AppColors.purple,
                                    shape: BoxShape.circle
                                ),
                                child: const CustomImage(imageSrc: AppIcons.question,size: 14,),
                              ),
                               CustomText(
                                textAlign: TextAlign.start,
                                text: _questionController.questionList[index].question??"",
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: AppColors.black_100,
                                left: 8,
                              ),
                            ],
                          ),
                          CustomTextFieldUnderline(
                            textEditingController:_questionController.controllerList[index],
                            fillColor: AppColors.white,
                            textAlign: TextAlign.start,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Answer this question';
                              }
                              return null;
                            },
                            hintText: AppStrings.writeYourAnswer,
                            hintStyle: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_40),
                            inputTextStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.black_100),
                            fieldBorderColor: AppColors.black_40,
                            fieldBorderRadius: 8,

                          ),
                        ],
                      );
                    }, separatorBuilder: (context,index){
                      return SizedBox(height: 24.h,);
                    }, itemCount:_questionController.questionList.length)


                  ],
                ),
              ),
            ),
          );
        },
      ),
        bottomNavigationBar:Obx(()=>
           Padding(
             padding:  EdgeInsets.only(left: 20.w,right: 20.w,bottom: 50.h),
             child: NewCustomButton(onTap:(){
               if(_key.currentState!.validate()){
                 _questionController.answerQuestion();
               }
          }, text:AppStrings.submit,loading:_questionController.answerLoading.value,),
           ),
        )
    ));
  }
}


