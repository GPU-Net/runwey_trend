import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/model/question_model.dart';
import 'package:runwey_trend/services/api_check.dart';
import 'package:runwey_trend/services/api_client.dart';
import 'package:runwey_trend/services/api_constant.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/view/screens/add/Controller/controller_add_video.dart';

import '../question/inner_widgets/custom_alert_box.dart';

class QuestionController extends GetxController {
  RxList<Question> questionList = <Question>[].obs;
  RxList<TextEditingController> controllerList = <TextEditingController>[].obs;
    final _addVideoController = Get.put(AddVideoController());


  var loading = false.obs;

  getQuestion() async {
    loading(true);
    var response = await ApiClient.getData(ApiConstant.questions);
    if (response.statusCode == 200) {
      QuestionsModel demoModel = QuestionsModel.fromJson(response.body);
      controllerList.clear();
      questionList.clear();
      questionList.value = demoModel.data ?? [];
      for (var element in demoModel.data!) {
        controllerList.add(TextEditingController());
      }
      controllerList.refresh();
      questionList.refresh();
      loading(false);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  var answerLoading = false.obs;

  answerQuestion() async {
    answerLoading(true);
    var answer = [];
    for (int i = 0; i < controllerList.length; i++) {
      answer.add(
          {"question": questionList[i].question, "answer": controllerList[i].text});
    }
    var response = await ApiClient.postData(ApiConstant.questionAnswer,json.encode(answer));
    if (response.statusCode == 200) {
      _addVideoController.getPermission();
      controllerList.clear();
      questionList.clear();
      showDialog(context: Get.context!,barrierDismissible: false, builder: (_)=>const CustomAlertBox());
    } else {
      ApiChecker.checkApi(response);
    }
    answerLoading(false);
  }
}
