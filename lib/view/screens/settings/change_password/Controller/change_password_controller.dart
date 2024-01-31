import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';

class ChangePasswordController extends GetxController{
  
  TextEditingController oldPassword=TextEditingController();
  TextEditingController newPassword=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  var loading=false.obs;
  
  changePassword()async{
    loading(true);
    var body={
      "oldPassword": oldPassword.text,
      "newPassword": confirmPassword.text
    };
    var response= await ApiClient.postData(ApiConstant.changePassword, json.encode(body));
    if(response.statusCode==200){
      Fluttertoast.showToast(msg:response.body['message']);
      oldPassword.clear();
      newPassword.clear();
      confirmPassword.clear();
      Get.back();
    }else{
      ApiChecker.checkApi(response,getXSnackBar: true);
    }
    loading(false);
  }
  
}