import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../model/category_model.dart';
import '../../../../services/api_check.dart';
import '../../../../services/api_client.dart';
import '../../../../services/api_constant.dart';
import '../../../../utils/app_constent.dart';

class SearchOccasionsController extends GetxController{

  final rxRequestStatus=Status.loading.obs;
  void setRxRequestStatus (Status _value)=>rxRequestStatus.value=_value;
  RxList<CategoryModel> categoryList=<CategoryModel>[].obs;
  RxList<CategoryModel> mainDemoList=<CategoryModel>[].obs;
   TextEditingController searchController=TextEditingController();
   var isSearch=false.obs;

  getCategory()async{
    var response= await ApiClient.getData(ApiConstant.getCategory);
    if(response.statusCode==200){

    var demoList =List<CategoryModel>.from(response.body['data']['attributes'].map((x) => CategoryModel.fromJson(x)));
    categoryList.value =demoList;
    mainDemoList.value=demoList;

     // categoryList.value=List<CategoryModel>.from(response.body['data']['attributes'].map((x) => CategoryModel.fromJson(x)));

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

   searchByName(String targetName) {
    if(targetName.isNotEmpty){
      isSearch(true);
      var demoList=mainDemoList.where((item) => item.name!.toLowerCase().contains(targetName.toLowerCase())).toList();
      categoryList.value=demoList;
      categoryList.refresh();
    }else{
      isSearch(false);
      categoryList.value=mainDemoList;
      categoryList.refresh();
    }



  }





}