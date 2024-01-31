import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/settings/about_us/about_us_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final _aboutUs = Get.put(AboutUsController());
  @override
  void initState() {
    DeviceUtils.authUtils();
    _aboutUs.getAboutUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar:  CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(),
              const CustomText(
                text: AppStrings.aboutUs,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.black_100,
              ),
              const SizedBox()
            ],
          )),
      body: Obx(() {
        switch (_aboutUs.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: () {
              _aboutUs.getAboutUs();
            });
          case Status.error:
            return GeneralErrorScreen(onTap: () {
              _aboutUs.getAboutUs();
            });
          case Status.completed:
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    children: [
                      Html(data: _aboutUs.aboutUs.data!.aboutUs)
                    ],
                  ));
            });
        }
      }),
    );
  }
}

/*LayoutBuilder(
builder: (BuildContext context,BoxConstraints constraints){
return  SingleChildScrollView(
padding: EdgeInsets.symmetric(vertical: 24,horizontal: 20),
child: Column(
children: [
CustomAppBar(
appBarContent: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
GestureDetector(
onTap:(){
Get.back();
},
child: const CustomImage(
imageSrc: AppIcons.backIcon,
size: 18,
),
),
const CustomText(
text: AppStrings.aboutUs,
fontSize: 18,
fontWeight: FontWeight.w500,
color: AppColors.black_100,
),
const SizedBox()
],
)),
SizedBox(height: 44,),
Row(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.start,
children: [
CustomText(
text: '1.',
color: AppColors.black_100,
right: 4,
),

Expanded(
child: CustomText(
maxLines: 3,
text: AppStrings.loremIpsumDolor,
color: AppColors.black_100,
),
),
],
),
SizedBox(height: 8,),
Row(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.start,
children: [
CustomText(
text: '2.',
color: AppColors.black_100,
right: 4,
),

Expanded(
child: CustomText(
maxLines: 3,
text: AppStrings.loremIpsumDolor,
color: AppColors.black_100,
),
),
],
),
SizedBox(height: 8,),
Row(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.start,
children: [
CustomText(
text: '3.',
color: AppColors.black_100,
right: 4,
),

Expanded(
child: CustomText(
maxLines: 3,
text: AppStrings.loremIpsumDolor,
color: AppColors.black_100,
),
),
],
),
SizedBox(height: 8,),
Row(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.start,
children: [
CustomText(
text: '4.',
color: AppColors.black_100,
right: 4,
),

Expanded(
child: CustomText(
maxLines: 3,
text: AppStrings.loremIpsumDolor,
color: AppColors.black_100,
),
),
],
),
SizedBox(height: 8,),
Row(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.start,
children: [
CustomText(
text: '5.',
color: AppColors.black_100,
right: 4,
),

Expanded(
child: CustomText(
maxLines: 3,
text: AppStrings.loremIpsumDolor,
color: AppColors.black_100,
),
),
],
),
],
)
);
}
),*/
