import 'package:get/get.dart';
import 'package:runwey_trend/model/subscription_model.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';

import '../../../../../utils/app_constent.dart';

class PurchaseSubscriptionController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  RxList<SubscriptionModel> subscriptionList = <SubscriptionModel>[].obs;

  var selectSubscription=0.obs;

  getSubscription() async {
    setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(ApiConstant.subscription);
    if (response.statusCode == 200) {
      subscriptionList.value = List<SubscriptionModel>.from(
          response.body['data'].map((x) => SubscriptionModel.fromJson(x)));
      subscriptionList.refresh();
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
