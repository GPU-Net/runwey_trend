import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/model/subscription_model.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/app_constent.dart';
import '../inner_widgets/payment_standard_alert_box.dart';

class PaymentController extends GetxController{

  TextEditingController cardCtrl=TextEditingController();
  TextEditingController expireCtrl=TextEditingController();
  TextEditingController cvvCtrl=TextEditingController();
  TextEditingController cardHolderNameCtrl=TextEditingController();
var isLoading=false.obs;

  Future<void> tokenizeCard(SubscriptionModel subscriptionModel) async {
    print( expireCtrl.text.substring(0,2));
    print( expireCtrl.text.substring(3,5));
    isLoading(true);
    update();
    try {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        //'Authorization': 'Bearer sk_test_51NaUtTDtqwXq49RqqTsY5uXzpmE8rIB07yEkh565hO2MyXUu7BqsfhZaHPTD9WPAefkiagOsujnLlL14xl3GciYK007ZlVMXFD'
         'Authorization': 'Bearer ${AppConstants.secretKey}'
      };
      var request = http.Request('POST', Uri.parse(ApiConstant.stripeUrl));

      request.bodyFields = {
        'card[exp_month]': expireCtrl.text.substring(0,2),
        'card[exp_year]': expireCtrl.text.substring(3,5),
        'card[number]': cardCtrl.text,
        'card[cvc]': cvvCtrl.text
      };
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        var data=json.decode(await response.stream.bytesToString());
        print(data['id']);
        update();
        await handlePayment(subscriptionModel,data['id']);
        isLoading(false);
      }
      else {
        print("error : ${response.reasonPhrase} ");
        Fluttertoast.showToast(msg:response.reasonPhrase!);
        //await handlePayment(subscriptionModel,'tok_visa');
        isLoading(false);
      }
    } on Exception catch (e) {
      isLoading(false);
      debugPrint("Oops!, Something wrong");
      // TODO
    }finally{
      isLoading(false);
    }

  }

  // showDialog<void>(
  // context: context,
  // barrierDismissible: false, // user must tap button!
  // builder: (BuildContext context) {
  // return const PaymentStandardAlertBox();
  // },
  // );


  handlePayment(SubscriptionModel subscriptionModel,String id)async{
    var body={
      "subscriptionId": subscriptionModel.package.id,
      "token": {
        "id": "tok_visa"
      }
    };

    var response= await ApiClient.postData(ApiConstant.payment, json.encode(body));
    if(response.statusCode==200){
      showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
      return  PaymentStandardAlertBox(subscriptionModel: subscriptionModel,);
      },
      );
    }else{
      Fluttertoast.showToast(msg:response.statusText!);
    }
  }



}