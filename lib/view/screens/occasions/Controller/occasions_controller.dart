import 'package:get/get.dart';

import '../../../../model/category_model.dart';
import '../../../../services/api_check.dart';
import '../../../../services/api_client.dart';
import '../../../../services/api_constant.dart';
import '../../../../utils/app_constent.dart';

class OccasionsController extends GetxController{

  final rxRequestStatus=Status.loading.obs;
  void setRxRequestStatus (Status _value)=>rxRequestStatus.value=_value;
  RxList<CategoryModel> categoryList=<CategoryModel>[].obs;

  getCategory()async{
    var response= await ApiClient.getData(ApiConstant.getCategory);
    if(response.statusCode==200){
      categoryList.value=List<CategoryModel>.from(response.body['data']['attributes'].map((x) => CategoryModel.fromJson(x)));
      setRxRequestStatus(Status.completed);
    }else{
      if(response.statusText==ApiClient.noInternetMessage){
        setRxRequestStatus(Status.internetError);
      }else{
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }

  }




}