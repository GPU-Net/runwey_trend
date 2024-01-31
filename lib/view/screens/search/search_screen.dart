import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_images.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_search_field.dart';

import '../../../utils/app_constent.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/general_error_screen.dart';
import '../../widgets/no_internet_screen.dart';
import '../../widgets/occasions_card.dart';
import 'Controller/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final _searchController = Get.put(SearchOccasionsController());

  @override
  void initState() {
    DeviceUtils.authUtils();
    _searchController.getCategory();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.purple,
          systemNavigationBarIconBrightness: Brightness.light));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      switch (_searchController.rxRequestStatus.value) {
        case Status.loading:
          return const CustomLoader();
        case Status.error:
          return GeneralErrorScreen(onTap: () {
            _searchController.getCategory();
          });
        case Status.internetError:
          return NoInternetScreen(onTap: () {
            _searchController.getCategory();
          });
        case Status.completed:
          return  LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                  child: Obx(()=>
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               CustomSearchField(
                                 hint: 'Search by occasion',
                                 suffixIcon:_searchController.isSearch.value? GestureDetector(
                                   onTap:(){

                                     _searchController.searchController.clear();
                                     _searchController.searchByName("");
                                     debugPrint("Clear Text Controller");
                                   },
                                   child: Padding(
                                     padding: const EdgeInsets.all(10.0),
                                     child: SvgPicture.asset(AppIcons.xCircle,height: 24,width: 24,color: Color(0xFFD6D6D6),),
                                   ),
                                 ):null,
                                 prefixIcon:const Icon(Icons.search,color: Colors.black12,),
                                 textEditingController:_searchController.searchController,
                                  onChanged:(value){
                                   _searchController.searchByName(value??"");
                                  },
                               ),
                               _searchController.isSearch.value?SizedBox(height:20.h,):
                               const CustomText(
                                 text: AppStrings.featured,
                                 fontSize: 18,
                                 fontWeight: FontWeight.w600,
                                 color: AppColors.black_100,
                                 bottom: 16,
                                 top: 32,
                               ),
                             ],
                           ),
                          Expanded(
                            child:_searchController.isSearch.value&&_searchController.categoryList.isEmpty?const Center(child:Text("No data found",style: TextStyle(fontSize: 18,color: Colors.black45),),):MasonryGridView.builder(
                              shrinkWrap: true,
                              crossAxisSpacing: 8.w,
                              mainAxisSpacing: 8.h,
                              physics: const AlwaysScrollableScrollPhysics(),
                              // padding:
                              // const EdgeInsets.only(top: 10, left: 20, right: 20),
                              itemCount: _searchController.categoryList.length,
                              gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                var data = _searchController.categoryList[index];
                                return OccasionsCard(categoryModel: data);
                              },
                            ),
                          ),
                        ]),
                  ),
                );
              });
      }
    });



    // return LayoutBuilder(
    //     builder: (BuildContext context, BoxConstraints constraints) {
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
    //         child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const Expanded(
    //                 flex: 0,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     CustomSearchField(hint: 'Search by occasion'),
    //                     CustomText(
    //                       text: AppStrings.featured,
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w600,
    //                       color: AppColors.black_100,
    //                       bottom: 16,
    //                       top: 32,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Expanded(
    //                 child:MasonryGridView.builder(
    //                   shrinkWrap: true,
    //                   crossAxisSpacing: 8.w,
    //                   mainAxisSpacing: 8.h,
    //                   physics: const AlwaysScrollableScrollPhysics(),
    //                   padding:
    //                   const EdgeInsets.only(top: 10, left: 20, right: 20),
    //                   itemCount: _searchController.categoryList.length,
    //                   gridDelegate:
    //                   const SliverSimpleGridDelegateWithFixedCrossAxisCount(
    //                     crossAxisCount: 2,
    //                   ),
    //                   itemBuilder: (context, index) {
    //                     var data = _searchController.categoryList[index];
    //                     return OccasionsCard(categoryModel: data);
    //                   },
    //                 ),
    //               ),
    //             ]),
    //       );
    //     });
  }
}
