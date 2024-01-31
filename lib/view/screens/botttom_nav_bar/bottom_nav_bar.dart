import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/add/add/add_screen.dart';
import 'package:runwey_trend/view/screens/home/home/home_screen.dart';
import 'package:runwey_trend/view/screens/occasions/occasions/occasions_screen.dart';
import 'package:runwey_trend/view/screens/profile/profile_screen.dart';
import 'package:runwey_trend/view/screens/search/search_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../../../helper/network_info.dart';

class CustomNavBar extends StatefulWidget {

  CustomNavBar({super.key, required this.currentIndex});

  late int currentIndex;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    DeviceUtils.whiteUtils();
    NetworkInfo.checkConnectivity(_scaffoldKey);
    super.initState();
  }


  static const List<Widget> screens = <Widget>[
    HomeScreen(),
    SearchScreen(),
    AddScreen(),
    OccasionsScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    DeviceUtils.whiteUtils();
    List<Widget> manuBarItems = [
      MenuBarItems(
          text: AppStrings.home,
          index: 0,
          selectedIndex: widget.currentIndex,
          image: AppIcons.home2),
      MenuBarItems(
          text:AppStrings.search,
          index: 1,
          selectedIndex: widget.currentIndex,
          image: AppIcons.searchNormal
      ),
      MenuBarItems(
          text: AppStrings.add,
          index: 2,
          selectedIndex: widget.currentIndex,
          image: AppIcons.add
      ),
      MenuBarItems(
          text: AppStrings.occasions,
          index: 3,
          selectedIndex: widget.currentIndex,
          image: AppIcons.element
      ),
      MenuBarItems(
          text: AppStrings.profile,
          index: 4,
          selectedIndex: widget.currentIndex,
          image: AppIcons.frame
      ),
    ];
    return SafeArea(
      bottom: false,
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        bottomNavigationBar: Container(
           height: 90.h,
          alignment: Alignment.bottomCenter,
          decoration:   const BoxDecoration(
            color: AppColors.purple,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(manuBarItems.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    widget.currentIndex = index;
                  });
                },
                child: manuBarItems[index],
              );
            }),
          ),
        ),
        body: screens[widget.currentIndex],
      ),
    );
  }
}

class MenuBarItems extends StatelessWidget {
  const MenuBarItems(
      {super.key,
        required this.image,
        required this.index,
        required this.selectedIndex,
        required this.text});
  final String image;
  final String text;

  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:19.h,bottom:selectedIndex==index?10.h:17.h,left:15.w,right: 15.w),
      child: Column(
        children: [
          CustomImage(
              imageColor:selectedIndex == index  ? AppColors.white:AppColors.white,size:23.h,
              imageSrc: image),
          CustomText(
            fontSize:12.h,
            fontWeight:selectedIndex == index ? FontWeight.w600 : FontWeight.w400,
            text: text,
            color: selectedIndex == index ? AppColors.white : AppColors.white,
            top: 4.h,
            bottom: 4.h,
          ),
          if(selectedIndex==index)
          Container(
            height: 8.h,
            width: 8.h,
            decoration: BoxDecoration(
              color: selectedIndex == index ? AppColors.white : AppColors.purple,
              shape: BoxShape.circle
            ),
          )
        ],
      ),
    );
  }
}