class ApiConstant{
  static String baseUrl="http://103.145.138.77:3002/api";
  static String  socketUrl="ws://103.145.138.77:3002";

  static String signUpEndPoint="/users/sign-up";
  static String signInEndPoint="/users/sign-in";
  static String otpVerifyEndPoint="/users/verify";
  static String forgetEndPoint="/users/forget-password";
  static String resetPassword="/users/update-password";
  static String questions="/question";
  static String questionAnswer="/answer/question-answer";
  static String getProfile="/users/profile-data";
  static String getCategory="/categories";
   static String uploadContent="/contents/upload";
  static String newestContent="/contents/newest-videos";
  static String popularContent="/contents/popular-content";
  static String myContent="/contents/my-content";
  static String similarContent="/contents/similar/";
  static String wishListContent="/wishlisted-video/";
  static String storeListContent="/contents/show-own-content/";
  static String contentDetails="/contents/video-details/";
  static String userByContent="/contents/contents-by-creator/";
  static String addWishList="/wishlist";
  static String wishRemove="/wishlists";
  static String wishList="/wishlist";
  static String updateProfile="/users/update";
  static String editContent="/contents/";
  static String deleteContent="/contents/delete-content/";
  static String searchContent="/contents/videos";
  static String changePassword="/users/change-password";
  static String rating="/rating/";
  static String message="/messages/";
  static String aboutUs="/aboutus";
  static String privacy="/privacy";
  static String termCondition="/termCondition";
  static String subscription="/subscribe";
  static String payment="/payment";
  static String notification="/notification";
  static String banner="/banner";
  static String mySubscription="/my-subscription";




  ///
  static  String stripeUrl = "https://api.stripe.com/v1/tokens";
}