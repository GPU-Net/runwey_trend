import 'package:intl/intl.dart';

class DateFormatHelper{



  /// 22-03-1998
 static String formatDate(DateTime date) {
   // Define the desired date format
   final DateFormat formatter = DateFormat('dd-MM-yyyy');

   // Format the date using the defined format
   return formatter.format(date);
 }
///  Format the date using the "01 Aug" format
 static String formatCustomDate(DateTime date) {
   return DateFormat('dd MMM').format(date);
 }

 static String formatTimeHHMM(DateTime time) {
   // Format the time in the "HH:mm" format
   return DateFormat('HH:mm').format(time);
 }

 ///  Format the date using the "25 October, 2023" format
 static String formatDateDDMMMMYYYY(DateTime date) {
   // Define the desired output format
   String outputFormat = 'dd MMMM, yyyy';

   // Format the date
   return DateFormat(outputFormat).format(date);
 }




 ///  a hour ago and mmm d, y , h:mm a
 static String timeAgoFormat(DateTime time) {
   final now = DateTime.now();
   final difference = now.difference(time);

   if (difference.inSeconds < 60) {
     return '${difference.inSeconds} seconds ago';
   } else if (difference.inMinutes < 60) {
     return '${difference.inMinutes} minutes ago';
   } else if (difference.inHours < 24) {
     return '${difference.inHours} hours ago';
   } else {
     return DateFormat('MMM d, y H:mm a').format(time);
   }
 }
}