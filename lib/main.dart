import 'dart:io';

import 'package:camera/camera.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:runwey_trend/helper/notification_helper.dart';
import 'package:runwey_trend/helper/socket_maneger.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/style.dart';
import 'core/route/app_route.dart';

FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final cameras = await availableCameras();
  // final firstCamera = cameras.first;
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //
  // );
  NotificationHelper.initLocalNotification(fln);
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SocketApi.init();
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.noTransition,
            initialRoute: AppRoute.splashScreen,
            navigatorKey: Get.key,
            theme: ThemeData(
                appBarTheme: AppBarTheme(
                    elevation: 0,
                    centerTitle: true,
                    color: AppColors.white,

                    titleTextStyle: AppStyles.h3(
                        fontWeight: FontWeight.w500, color: Colors.black),
                    toolbarHeight: 64.h)),
            transitionDuration: const Duration(milliseconds: 200),
            getPages: AppRoute.routes,
            localizationsDelegates: const [
              CountryLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // arabic, no country code
            ],
          );
        });
  }
}
