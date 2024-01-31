import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:runwey_trend/utils/app_colors.dart';


class DeviceUtils{

  static void splashUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.white,
          statusBarColor: AppColors.purple,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarDividerColor: Colors.transparent,
        )
    );
  }
  static void profileUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.purple,
          statusBarColor: AppColors.purple,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarDividerColor: Colors.transparent,
        )
    );
  }

  static void imageUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.whiteBg,
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarDividerColor: Colors.transparent,
        )
    );
  }
  // if (Platform.isAndroid) {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  // systemNavigationBarColor: AppColors.purple,
  // systemNavigationBarIconBrightness: Brightness.light));
  // }
  static void authUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.purple,
          statusBarColor: AppColors.whiteBg,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarDividerColor: Colors.transparent,
        )
    );
  }

  static void whiteUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.purple,
          statusBarColor: AppColors.whiteBg,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarDividerColor: Colors.transparent,
        )
    );
  }

  static void screenUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.whiteBg,
          statusBarColor: AppColors.purple,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarDividerColor: Colors.transparent,
        )
    );
  }

  static void allScreenUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.whiteBg,
          statusBarColor: AppColors.whiteBg,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarDividerColor: Colors.transparent,
        )
    );
  }


}