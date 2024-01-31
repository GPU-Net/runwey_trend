import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/product_details/inner_widgets/description_section.dart';
import 'package:runwey_trend/view/screens/product_details/inner_widgets/product_details_section.dart';
import 'package:runwey_trend/view/screens/product_details/inner_widgets/top_reviews_section.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/buttons/custom_back_button.dart';
import 'Controller/products_details_controller.dart';
import 'inner_widgets/similar_bottom_section.dart';
import 'inner_widgets/summer_gown_top_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var data = Get.parameters;
  final _contentDetailsController = Get.put(ContentDetailsController());

  @override
  void initState() {
    super.initState();
    DeviceUtils.screenUtils();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _contentDetailsController.getProductsDetails(data['contentId']!,true);
      });
    });

    DeviceUtils.authUtils();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (_contentDetailsController.rxRequestStatus.value) {
        case Status.loading:
          return  const Scaffold(
              appBar: CustomAppBar(
                  appBarContent: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(),
                      SizedBox(),
                      SizedBox()
                    ],
                  )),
              body: CustomLoader());
        case Status.internetError:
          return Scaffold(
            appBar: const CustomAppBar(
                appBarContent: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(),
                    SizedBox(),
                    SizedBox()
                  ],
                )),
            body: NoInternetScreen(onTap: () {
              _contentDetailsController.getProductsDetails(data['contentId']!,true);
            }),
          );
        case Status.error:
          return Scaffold(
            appBar: CustomAppBar(
                appBarContent: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 16,
                        color: AppColors.black_100,
                      ),
                    ),
                   const SizedBox(),
                    const SizedBox()
                  ],
                )),
            body: GeneralErrorScreen(onTap: () {
              _contentDetailsController.getProductsDetails(data['contentId']!,true);
            }),
          );
        case Status.completed:
          return Scaffold(
              backgroundColor: AppColors.whiteBg,
              appBar: CustomAppBar(
                  appBarContent: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 16,
                      color: AppColors.black_100,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _contentDetailsController.contentDetailsModel.value.attributes!.video!.title??"",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.montserrat(
                        color: AppColors.black_100,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox()
                ],
              )),
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         SummerGownTopSection(screenType: data['screenType']!,),
                        ProductDetailsSection(contentDetailsModel:_contentDetailsController.contentDetailsModel.value,),

                    if(_contentDetailsController.contentDetailsModel.value.attributes!.reviews!.isNotEmpty)
                       TopReviewsSection(contentDetailsModel:_contentDetailsController.contentDetailsModel.value,),
                        DescriptionSection(contentDetailsModel:_contentDetailsController.contentDetailsModel.value,),
                        SimilarBottomSection(contentDetailsModel:_contentDetailsController.contentDetailsModel.value,)
                      ],
                    ),
                  );
                },
              ));
      }
    });
  }
}
