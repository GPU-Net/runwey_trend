import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/helper/Bindings/navbar_bindings.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';

import '../../../../../helper/prefs_helper.dart';
import '../../../../../helper/socket_maneger.dart';
import '../../../../../services/socket_constant.dart';
import '../../../../../utils/app_constent.dart';
import '../../../botttom_nav_bar/bottom_nav_bar.dart';

class ShowMyVideoController extends GetxController {
  var loading = false.obs;
  deleteContentVideo(String id) async {
    loading(true);
    Get.back();
    var response = await ApiClient.deleteData(ApiConstant.deleteContent + id);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      Get.offAll(CustomNavBar(currentIndex: 0),binding: NavBarBinding());
    } else {
      ApiChecker.checkApi(response);
    }
    loading(false);
  }



}
