import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/settings/terms_services/terms_service_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../widgets/buttons/custom_back_button.dart';

class TermsServicesScreen extends StatefulWidget {
  const TermsServicesScreen({super.key});

  @override
  State<TermsServicesScreen> createState() => _TermsServicesScreenState();
}

class _TermsServicesScreenState extends State<TermsServicesScreen> {
  final _terms = Get.put(TermsServiceController());
  @override
  void initState() {
    DeviceUtils.authUtils();
    _terms.getTermsService();
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
                text: AppStrings.termsOfServices,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.black_100,
              ),
              const SizedBox()
            ],
          )),
      body: Obx(() {
        switch (_terms.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: () {
              _terms.getTermsService();
            });
          case Status.error:
            return GeneralErrorScreen(onTap: () {
              _terms.getTermsService();
            });
          case Status.completed:
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                      child: Column(
                        children: [
                          Html(data: _terms.termsService.data!.termAndCondition)
                        ],
                      ));
                });
        }
      }),
    );
  }
}
