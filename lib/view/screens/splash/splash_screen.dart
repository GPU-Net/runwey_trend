import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/splash/splash_controller.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final _splashController = Get.put(SplashController());
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  @override
  void initState() {
    DeviceUtils.splashUtils();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : _globalKey.currentState?.hideCurrentSnackBar();
        _globalKey.currentState?.showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? "No internet connection" : "Connected",
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _splashController.jumpToNextPage();
        }
      }
      firstTime = false;
    });

    _splashController.jumpToNextPage();
    super.initState();
  }
  @override
  void dispose() {
    DeviceUtils.imageUtils();
    _onConnectivityChanged.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFFDFBFB), Colors.white, Color(0xFFF4F4F4)],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: -280,
              top: -85,
              child: Container(
                width: 823,
                height: 823,
                decoration: const ShapeDecoration(
                  color: Color(0xFFA370EC),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: -248,
              top: -110,
              child: Container(
                width: 823,
                height: 823,
                decoration: const ShapeDecoration(
                  color: Color(0xFF8541E6),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: -217,
              top: -131,
              child: Container(
                width: 823,
                height: 823,
                decoration: const ShapeDecoration(
                  color: Color(0xFF6611E0),
                  shape: OvalBorder(),
                ),
              ),
            ),
             Positioned(
              top: 410.h,
              child: const CustomImage(imageSrc:AppIcons.splashLogoSvg)
            ),
          ],
        ),
      )),
    );
  }
}
