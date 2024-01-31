import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runwey_trend/helper/prefs_helper.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/home/Controller/newest_controller.dart';
import 'package:runwey_trend/view/screens/home/newest/inner_widgets/newest_end_drawer.dart';
import 'package:runwey_trend/view/screens/home/newest/inner_widgets/newest_product_section.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/buttons/custom_back_button.dart';
import 'package:runwey_trend/view/widgets/custom_circle_loading.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_search_field.dart';

class NewestScreen extends StatefulWidget {
  const NewestScreen({super.key});

  @override
  State<NewestScreen> createState() => _NewestScreenState();
}

class _NewestScreenState extends State<NewestScreen> {
  final _controller = Get.put(NewestController());

  @override
  void initState() {
    DeviceUtils.authUtils();
    _controller.selectCategory.value = "";
    selectGender();
    _controller.scrollController = ScrollController();
    _controller.scrollController.addListener(() {
      if (_controller.scrollController.position.pixels ==
          _controller.scrollController.position.maxScrollExtent) {
        _controller.loadMore();
      }
    });
    super.initState();
  }

  selectGender()async{
    String gender= await PrefsHelper.getString(AppStrings.gender);
    _controller.selectGender.value =gender.isNotEmpty?gender:"All";
    _controller.selectCategory.value="";
    _controller.fastLoad();
  }

  @override
  void dispose() {selectGender();
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Obx(() {
        switch (_controller.rxRequestStatus.value) {
          case Status.loading:
            return  Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.newest),
                leading: const CustomBackButton(),
              ),
              body: CustomLoader(),
            );
          case Status.internetError:
            return Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.newest),
                leading: const CustomBackButton(),
              ),
              body: NoInternetScreen(onTap: () {
                _controller.fastLoad();
              }),
            );
          case Status.error:
            return Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.newest),
                leading: const CustomBackButton(),
              ),
              body: GeneralErrorScreen(onTap: () {
                _controller.fastLoad();
              }),
            );
          case Status.completed:
            return buildScaffold();
        }
      }),
    );
  }

  buildScaffold() {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const Drawer(
        backgroundColor: Colors.transparent,
        child: NewestEndDrawer(),
      ),
      backgroundColor: AppColors.whiteBg,
      appBar: AppBar(
        title: const Text(AppStrings.newest),
        leading: const CustomBackButton(),
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomSearchField(
                    hint: 'Search Product',
                    onChanged: (value) {
                      _controller.searchText.value = value ?? "";
                      _controller.searchLoad();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => scaffoldKey.currentState!.openEndDrawer(),
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 10, horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColors.black_20, width: 1)),
                    child: SvgPicture.asset(AppIcons.adjustments),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _controller.searchLoading.value
                    ? const CustomCircleLoader()
                    : _controller.newestContentList.isEmpty
                        ? const Center(
                            child: Text(
                              "No data found",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : const NewestProductSection()),
          ),
        ],
      ),
    );
  }
}
