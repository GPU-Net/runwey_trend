import 'package:get/get.dart';
import 'package:runwey_trend/helper/Bindings/navbar_bindings.dart';
import 'package:runwey_trend/utils/app_constent.dart';

import '../../../core/route/app_route.dart';
import '../../../helper/prefs_helper.dart';
import '../botttom_nav_bar/bottom_nav_bar.dart';

class SplashController extends GetxController{


  jumpToNextPage() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      bool isOnboard = await PrefsHelper.getBool(AppConstants.onBoard);
      String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      if(isOnboard){
        if(bearerToken.isNotEmpty){
          Get.offAll(CustomNavBar(currentIndex:0),binding:NavBarBinding());
        }else{
          Get.offAllNamed(AppRoute.signInScreen);
        }
      }else{
        Get.offAllNamed(AppRoute.onboardScreen);
      }

    });
  }







}