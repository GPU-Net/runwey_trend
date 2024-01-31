import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/view/screens/add/Controller/controller_add_video.dart';
import 'package:runwey_trend/view/screens/home/Controller/home_controller.dart';
import 'package:runwey_trend/view/screens/occasions/Controller%20/occasions_controller.dart';
import 'package:runwey_trend/view/screens/profile/Controller/profile_controller.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(AddVideoController());
    Get.put(OccasionsController());
    Get.put(SearchController());
  }}