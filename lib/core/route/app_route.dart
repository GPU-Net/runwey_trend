import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:runwey_trend/view/screens/add/add/add_screen.dart';
import 'package:runwey_trend/view/screens/add/edit_video/edit_video_screen.dart';
import 'package:runwey_trend/view/screens/add/question/question_screen.dart';
import 'package:runwey_trend/view/screens/add/show_my_video/show_my_video_screen.dart';
import 'package:runwey_trend/view/screens/add/upload_video_details/upload_video_details_screen.dart';
import 'package:runwey_trend/view/screens/auth/sign_in/sign_in_screen.dart';
import 'package:runwey_trend/view/screens/auth/sign_up/sign_up_screen.dart';
import 'package:runwey_trend/view/screens/botttom_nav_bar/bottom_nav_bar.dart';
import 'package:runwey_trend/view/screens/home/home/home_screen.dart';
import 'package:runwey_trend/view/screens/home/newest/newest_screen.dart';
import 'package:runwey_trend/view/screens/home/popular/popular_screen.dart';
import 'package:runwey_trend/view/screens/message/message_screen.dart';
import 'package:runwey_trend/view/screens/my_whitelist/my_whitelist_screen.dart';
import 'package:runwey_trend/view/screens/my_whitelist/product_details/product_details_screen.dart';
import 'package:runwey_trend/view/screens/notification/notification_screen.dart';
import 'package:runwey_trend/view/screens/onboard/onboard_screen.dart';
import 'package:runwey_trend/view/screens/personal_information/edit_your_information/edit_your_information_screen.dart';
import 'package:runwey_trend/view/screens/personal_information/personal_information/personal_information_screen.dart';
import 'package:runwey_trend/view/screens/product_details/product_details_screen.dart';
import 'package:runwey_trend/view/screens/search/search_screen.dart';
import 'package:runwey_trend/view/screens/settings/about_us/about_us_screen.dart';
import 'package:runwey_trend/view/screens/settings/change_forget_password/change_forget_password_screen.dart';
import 'package:runwey_trend/view/screens/settings/change_otp/change_otp_screen.dart';
import 'package:runwey_trend/view/screens/settings/change_password/change_password_screen.dart';
import 'package:runwey_trend/view/screens/settings/change_update_password/change_update_password_screen.dart';
import 'package:runwey_trend/view/screens/settings/privacy_policy/privacy_policy_screen.dart';
import 'package:runwey_trend/view/screens/settings/settings/settings_screen.dart';
import 'package:runwey_trend/view/screens/settings/support/support_screen.dart';
import 'package:runwey_trend/view/screens/settings/terms_services/terms_services_screen.dart';

import 'package:runwey_trend/view/screens/splash/splash_screen.dart';
import 'package:runwey_trend/view/screens/store_all_videos/store_all_videos_screen.dart';
import 'package:runwey_trend/view/screens/auth/forget_password/forget_password_screen.dart';
import 'package:runwey_trend/view/screens/auth/otp/otp_screen.dart';
import 'package:runwey_trend/view/screens/auth/reset_password/reset_password_screen.dart';
import 'package:runwey_trend/view/screens/occasions/occasions/occasions_screen.dart';
import 'package:runwey_trend/view/screens/profile/profile_screen.dart';



import '../../view/screens/SimilarVideoContent/product_details/product_details_screen.dart';
import '../../view/screens/store_all_videos/StoreVideoContent/product_details/product_details_screen.dart';
import '../../view/screens/subscription/MySubscriptionPlan/my_subscription_plan_screen.dart';

import '../../view/screens/subscription/PurchaseSubscription/purchase_subscription/purchase_subscription_screen.dart';


class AppRoute {
  static String splashScreen = "/splash_screen";
  static String onboardScreen = "/onboard_screen";
  static String signInScreen = "/sign_in_screen";
  static String signUpScreen = "/sign_up_screen";
  static String homeScreen = "/home_screen";
  static String newestScreen = "/newest_screen";
  static String popularScreen = "/popular_screen";
  static String searchScreen = "/search_screen";
  static String addScreen = "/add_screen";
  static String questionScreen = "/question_screen";
  static String settingsScreen = "/settings_screen";
  static String changePassword = "/change_password_screen";
  static String changeForgetPasswordScreen = "/change_forget_password_screen";
  static String changeOtpScreen = "/change_otp_screen";
  static String changeUpdatePasswordScreen = "/change_update_password_screen";
  static String termsServicesScreen = "/terms_services_screen";
  static String privacyPolicyScreen = "/privacy_policy_screen";
  static String aboutUsScreen = "/about_us_screen";
  static String uploadVideoDetails = "/upload_video_details_screen";
  // static String showMyVideoScreen = "/show_my_video_screen";
  // static String editVideoScreen = "/edit_video_screen";
  static String paymentPremiumScreen = "/payment_premium_screen";
  static String paymentStandardScreen = "/payment_standard_screen";
  static String regularSubscriptionPlanScreen = "/regular_subscription_plan_screen";
  static String premiumSubscriptionPlanScreen = "/premium_subscription_plan_screen";
  static String mySubscriptionPlanScreen = "/standard_subscription_plan_screen";
  static String purchaseSubscriptionScreen = "/purchase_subscription_screen";
  static  String forgetPasswordScreen = "/forget_password_screen";
  static  String otpScreen = "/otp_screen";
  static  String resetPasswordScreen = "/reset_password_screen";
  static  String occasionsScreen = "/occasions_screen";
  //static  String summerAllScreen = "/summer_all_screen";
  static  String profileScreen = "/profile_screen";
  static  String editYourInformation = "/edit_your_information_screen";
  static  String purchasePremiumPlanScreen = "/purchase_premium_plan_screen";
  static  String bottomNavBar = "/bottom_nav_bar";
  static  String productDetailsScreen = "/product_details_screen";
  static  String similarProductDetailsScreen = "/similar_product_details_screen";
  static  String storeProductDetailsScreen = "/store_product_details_screen";
  static  String wishListProductDetailsScreen = "/wish_list_product_details_screen";
  //static  String storeAllVideoScreen = "/store_all_video_screen";
  static  String myWishlistScreen = "/my_wish_list_screen";
  static  String personalInformation = "/personal_information";
  static  String chatScreen = "/chat_bubble";
  static  String supportScreen = "/support_screen";
  static  String notificationScreen = "/notification_screen";


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardScreen, page: () => const OnboardScreen()),
    GetPage(name: signInScreen, page: () => const SignInScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: newestScreen, page: () => const NewestScreen()),
    GetPage(name: popularScreen, page: () => const PopularScreen()),
    GetPage(name: searchScreen, page: () => const SearchScreen()),
    GetPage(name: addScreen, page: () => const AddScreen()),
    GetPage(name: questionScreen, page: () => const QuestionScreen()),
    GetPage(name: settingsScreen, page: () => const SettingsScreen()),
    GetPage(name: changePassword, page: () => const ChangePasswordScreen()),
    GetPage(name: changeForgetPasswordScreen, page: () => const ChangeForgetPasswordScreen()),
    GetPage(name: changeOtpScreen, page: () => const ChangeOtpScreen()),
    GetPage(name: changeUpdatePasswordScreen, page: () => const ChangeUpdatePasswordScreen()),
    GetPage(name: termsServicesScreen, page: () => const TermsServicesScreen()),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: aboutUsScreen, page: () => const AboutUsScreen()),
    GetPage(name: uploadVideoDetails, page: () => const UploadVideoDetailsScreen()),
    // GetPage(name: showMyVideoScreen, page: () => const ShowMyVideoScreen()),
    // GetPage(name: editVideoScreen, page: () => const EditVideoScreen()),
    GetPage(name: mySubscriptionPlanScreen, page: () => const MySubscriptionPlanScreen()),
    GetPage(name: purchaseSubscriptionScreen, page: () => const PurchaseSubscriptionScreen()),
    GetPage(name: forgetPasswordScreen, page: ()=> const Forget_Password_Screen()),
    GetPage(name: otpScreen, page: ()=> const OtpScreen()),
    GetPage(name: resetPasswordScreen, page: ()=> const ResetPasswordScreen()),
    GetPage(name: occasionsScreen, page: ()=> const OccasionsScreen()),
    //GetPage(name: summerAllScreen, page: ()=>  SummerAllScreen()),
    GetPage(name: profileScreen, page: ()=> const ProfileScreen()),
    GetPage(name: editYourInformation, page: ()=> const EditYourInformationScreen()),

    GetPage(name: bottomNavBar, page: ()=>  CustomNavBar(currentIndex: 0)),
    GetPage(name: productDetailsScreen, page: ()=>const  ProductDetailsScreen()),
    GetPage(name: similarProductDetailsScreen, page: ()=>const  SimilarProductDetailsScreen()),
    GetPage(name: storeProductDetailsScreen, page: ()=>const  StoreProductDetailsScreen()),
    //GetPage(name: storeAllVideoScreen, page: ()=>const  StoreAllVideoScreen()),
    GetPage(name: myWishlistScreen, page: ()=>const  MyWishlistScreen()),
    GetPage(name: personalInformation, page: ()=>const  PersonalInformation()),
    GetPage(name: chatScreen, page: ()=>const  ChatScreen()),
    GetPage(name: supportScreen, page: ()=>const  SupportScreen()),
    GetPage(name: notificationScreen, page: ()=>const  NotificationScreen()),
    GetPage(name: wishListProductDetailsScreen, page: ()=>const  WishListProductDetailsScreen()),

  ];
}
