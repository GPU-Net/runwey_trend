class AppConstants {

  static String bearerToken="BearerToken";
  static String userId="UserId";
  static String onBoard="Onboard";
  static String subscriptionType="SubscriptionType";
  static String gender="Gender";
  static String autoFieldCountry="AutoFieldCountry";
  static String autoFieldTiktok="AutoFieldTikTok";
  static String autoFieldInstagram="AutoFieldInstagram";


  /// <-------------- All Response Message Static---------->
  static String successful="Successful";
  static String error ="Oops, something went wrong";
  static String secretKey="sk_test_51NiWAKHloEqm4Hcr2bW9Od8OZL1ySHO48NmyqgylSNkvRfp3GRAtAPcgr0EldrlZQ5QbnrdPDOTlI8UmIGxv11di00HWChl1wB";










static RegExp emailValidate=RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');


 static  validateTextField(String value) {
    if (value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

}

/// otp screen type

 enum  OptScreenType {signupotp,forgotOtp}
 enum  ContentPermission {pendingCreator,creator,user}
 enum Status {loading,error,completed,internetError}
enum ProductScreenType {newest,popular,category}