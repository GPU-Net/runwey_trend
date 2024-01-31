import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/helper/date_formate_helper.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/profile/Controller/profile_controller.dart';
import 'package:runwey_trend/view/screens/subscription/MySubscriptionPlan/Controller/my_subscription_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_button.dart';
import 'package:runwey_trend/view/widgets/cache_nerwork_image.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../../core/route/app_route.dart';
import '../../../widgets/buttons/custom_back_button.dart';

class MySubscriptionPlanScreen extends StatefulWidget {
  const MySubscriptionPlanScreen({super.key});

  @override
  State<MySubscriptionPlanScreen> createState() =>
      _MySubscriptionPlanScreenState();
}

class _MySubscriptionPlanScreenState
    extends State<MySubscriptionPlanScreen> {

  final _mySubscriptionController= Get.put(MySubscriptionController());
  final _profileController= Get.put(ProfileController());

  @override
  void initState() {
    DeviceUtils.authUtils();
    _mySubscriptionController.getMySubscription();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.whiteBg,
          appBar:  const CustomAppBar(
            appBarContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(),
                CustomText(
                  text: AppStrings.mySubscriptionPlan,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_100,
                ),
                SizedBox()
              ],
            ),
          ),
          body:Obx((){
            switch (_mySubscriptionController.rxRequestStatus.value){
              case Status.loading:
                return const CustomLoader();
              case Status.error:
                return GeneralErrorScreen(onTap:(){_mySubscriptionController.getMySubscription();});
              case Status.internetError:
                return NoInternetScreen(onTap:(){_mySubscriptionController.getMySubscription();});
              case Status.completed:
                return _body();


            }
          }),
        ));
  }

   _body() {
    return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding:  const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                   width: MediaQuery.of(context).size.width,
                    decoration: ShapeDecoration(
                      color: colorConverter(_mySubscriptionController.mySubscription.value.data!.attributes!.subscriptionId!.mainColor??""),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration:  BoxDecoration(
                              shape: BoxShape.circle, color:colorConverter(_mySubscriptionController.mySubscription.value.data!.attributes!.subscriptionId!.opacity1??""),),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorConverter(_mySubscriptionController.mySubscription.value.data!.attributes!.subscriptionId!.opacity2??""),),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: AppColors.white),
                              child: CustomNetworkImage(imageUrl:_profileController.profileData.value.image!.publicFileUrl??"", height:100.h, width:100.h,boxShape: BoxShape.circle,),
                            ),
                          ),
                        ),
                         CustomText(
                          text:"You are ${_mySubscriptionController.mySubscription.value.data!.attributes!.subscriptionType??""} User",
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: AppColors.white,
                          top: 16,
                          bottom: 4,
                        ),
                        _mySubscriptionController.mySubscription.value.data!.attributes!.subscriptionType!="Regular"?
                         const CustomText(
                          text: 'Your package will expire on ',
                          fontSize: 12,
                          color: AppColors.white,
                        ):const CustomText(
                          text: 'For better features please try better plan',
                          fontSize: 12,
                          color: AppColors.white,
                        ),
                        if(_mySubscriptionController.mySubscription.value.data!.attributes!.subscriptionType!="Regular")
                         CustomText(
                          text: DateFormatHelper.formatDateDDMMMMYYYY(_mySubscriptionController.mySubscription.value.data!.attributes!.expiryDate!),
                          fontSize: 12,
                          color: AppColors.white,
                          bottom: 24,
                        ),
                        if(_mySubscriptionController.mySubscription.value.data!.attributes!.subscriptionType=="Regular")
                           SizedBox(height: 24.h,),
                        CustomButton(onPressed: () {
                          Get.toNamed(AppRoute.purchaseSubscriptionScreen);
                        },elevation: 0, titleText:_mySubscriptionController.mySubscription.value.data!.attributes!.subscriptionType=="Regular"? 'Upgrade':'Renew',titleColor:AppColors.black_100,topPadding: 9,bottomPadding: 9,leftPadding: 35,rightPadding: 35,)
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
  }

  Color colorConverter(String colorCode) => Color(int.parse(
    colorCode.replaceAll('#', '0xFF'),
  ));
}
