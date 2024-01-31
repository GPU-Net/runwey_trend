import 'package:url_launcher/url_launcher.dart';

class Helper{

 static String formatLikeAndViewCount(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 1000000) {
      double kCount = count / 1000.0;
      return '${kCount.toStringAsFixed(kCount.truncateToDouble() == kCount ? 0 : 1)}k';
    } else {
      double mCount = count / 1000000.0;
      return '${mCount.toStringAsFixed(mCount.truncateToDouble() == mCount ? 0 : 1)}m';
    }
  }

 static String formatDuration(double seconds) {
   Duration duration = Duration(seconds: seconds.toInt());

   int hours = duration.inHours;
   int minutes = (duration.inMinutes % 60);
   int remainingSeconds = (duration.inSeconds % 60);

   String formattedHours = hours.toString().padLeft(2, '0');
   String formattedMinutes = minutes.toString().padLeft(2, '0');
   String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
   return '$formattedMinutes:$formattedSeconds';
 }


 static launchInstagramProfile(String userName) async {
   // if (!await launchUrl(Uri.parse(url))) {
   //   throw Exception('Could not launch $url');
   // }
   await launchUrl(Uri.parse('instagram://user?username$userName'));
   if (!await launchUrl(Uri.parse('instagram://user?username=$userName'))) {
     await launchUrl(Uri.parse("https://www.instagram.com/$userName/"));
   }
 }

 static launchTikTokProfile(String userName) async {
   // Check if the TikTok app is installed
   if (await launchUrl(Uri.parse('com.zhiliaoapp.musically'))) {
     // Launch TikTok app with the profile link
     await launchUrl(Uri.parse("tiktok://user?sec_uid=&id=&sourceType=&shareItemId=@$userName"));
   } else {
     // If TikTok app is not installed, open the TikTok website
     await launchUrl(Uri.parse("https://www.tiktok.com/@$userName"));
   }
 }


}