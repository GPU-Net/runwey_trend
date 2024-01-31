
import 'package:get/get.dart';
import 'package:runwey_trend/core/route/app_route.dart';
import 'package:runwey_trend/helper/prefs_helper.dart';
import 'package:runwey_trend/utils/app_constent.dart';

import '../view/widgets/custom_snackbar.dart';




class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false})async{

    if(response.statusCode != 200){
      if(response.statusCode == 401) {
        // Get.put(AuthController()).clearSharedData();
        await PrefsHelper.remove(AppConstants.bearerToken);
         Get.offAllNamed(AppRoute.signInScreen);
      }else {
        showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
      }

    }


  }
}