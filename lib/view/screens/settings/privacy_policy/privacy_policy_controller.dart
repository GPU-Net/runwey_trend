import 'package:get/get.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/view/screens/settings/about_us/about_us_model.dart';
import 'package:runwey_trend/view/screens/settings/privacy_policy/privacy_policy_model.dart';

class PrivacyPolicyController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  // RxList<ContentModel> newestVideoList= <ContentModel>[].obs;
  late PrivacyPolicyModel privacy ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;



  getPrivacy() async {
    setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(ApiConstant.privacy);
    if (response.statusCode == 200) {
      privacy= PrivacyPolicyModel.fromJson(response.body);
      setRxRequestStatus(Status.completed);
    } else {
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }
}