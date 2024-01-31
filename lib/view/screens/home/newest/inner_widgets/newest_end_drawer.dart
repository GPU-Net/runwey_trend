import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/view/widgets/buttons/bottom_nav_button.dart';
import 'package:runwey_trend/view/widgets/buttons/new_custom_button.dart';

import '../../Controller/newest_controller.dart';

class NewestEndDrawer extends StatefulWidget {
  const NewestEndDrawer({super.key});

  @override
  State<NewestEndDrawer> createState() => _NewestEndDrawerState();
}

class _NewestEndDrawerState extends State<NewestEndDrawer> {
  final _controller = Get.put(NewestController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFF818181)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.black_100,
                  size: 20,
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.purple,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    children: List.generate(
                        _controller.genderList.length,
                        (index) => Obx(()=>
                           GestureDetector(
                                onTap: () {
                                  _controller.selectGender.value =
                                      _controller.genderList[index];
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 10, bottom: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: ShapeDecoration(
                                    color: _controller.genderList[index] ==
                                            _controller.selectGender.value
                                        ? AppColors.purple
                                        : AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: _controller.genderList[index] ==
                                                  _controller.selectGender.value
                                              ? AppColors.purple
                                              : AppColors.purple),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                    _controller.genderList[index],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                      color: _controller.genderList[index] ==
                                              _controller.selectGender.value
                                          ? AppColors.white
                                          : AppColors.purple,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                        )),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Select Occasions',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.purple,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    children: List.generate(
                        _controller.categoryList.length,
                        (index) => Obx(()=>
                           GestureDetector(
                                onTap: () {
                                  _controller.selectCategory.value =
                                      _controller.categoryList[index].name ?? "";
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 10, bottom: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 4),
                                  decoration: ShapeDecoration(
                                    color: _controller.categoryList[index].name ==
                                            _controller.selectCategory.value
                                        ? AppColors.purple
                                        : AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: _controller
                                                      .categoryList[index].name ==
                                                  _controller.selectCategory.value
                                              ? AppColors.purple
                                              : AppColors.purple),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                    _controller.categoryList[index].name ?? "",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                      color:
                                          _controller.categoryList[index].name ==
                                                  _controller.selectCategory.value
                                              ? AppColors.white
                                              : AppColors.purple,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                        )),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          NewCustomButton(
              onTap: () {
                _controller.searchLoad();
                Get.back();
              },
              text: AppStrings.apply),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
