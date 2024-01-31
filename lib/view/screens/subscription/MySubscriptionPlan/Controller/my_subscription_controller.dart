import 'package:get/get.dart';
import 'package:runwey_trend/model/my_subscription_model.dart';

import '../../../../../services/api_client.dart';
import '../../../../../services/api_constant.dart';
import '../../../../../utils/app_constent.dart';

class MySubscriptionController extends GetxController{

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  Rx<MySubscriptionModel> mySubscription= MySubscriptionModel().obs;


  getMySubscription() async {
    setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(ApiConstant.mySubscription);
    if (response.statusCode == 200) {
      mySubscription.value =MySubscriptionModel.fromJson(response.body);
      mySubscription.refresh();
      setRxRequestStatus(Status.completed);
    } else {
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
    }
  }



}