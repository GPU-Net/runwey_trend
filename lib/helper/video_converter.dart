 import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart'; // For platform messages
import 'package:path_provider/path_provider.dart';
// For file system access

class VideoConverter {

  static Future<String?> convertVideoToMp4(String inputFilePath,) async {
    try {
      final outputFilePath = path.setExtension(inputFilePath, '.mp4');
      final command = getFFmpegCommandForFile(inputFilePath,outputFilePath);

      await FFmpegKit.execute(command).then((session) async {
        // ... (handle conversion results and progress)
        debugPrint("=====> handle conversion results and progress");
      });
      print("Input format: $inputFilePath");
      print("Input format: $outputFilePath");
      return outputFilePath; // Return output path on success
    } catch (error) {
      print("Error during conversion: $error");
      return null;
    }
  }

  static String getFFmpegCommandForFile(String inputFilePath,String outputFilePath) {
    if (inputFilePath.endsWith(".mov") ||
        inputFilePath.endsWith(".mp4") ||
        inputFilePath.endsWith(".mkv") ||
        inputFilePath.endsWith(".avi") ||
        inputFilePath.endsWith(".hevc") ||
        inputFilePath.endsWith(".flv") ||
        inputFilePath.endsWith(".wmv")||inputFilePath.endsWith(".MOV")||inputFilePath.endsWith(".HEVC")) {
      return "-i $inputFilePath -c:v mpeg4 -c:a copy $outputFilePath";
    } else {
      throw Exception("Unsupported video format: $inputFilePath");
    }
  }

  //
  // Future<String> convertVideo() async {
  //   final String inputPath = "/private/var/mobile/.../trim.27DC7AC0-B7B9-4DCC-A4A6-1425FD2467DF.MOV";
  //   final String outputPath = "/path/to/output/video.mp4"; // Specify your desired output path
  //
  //   final CompressResult result = await VideoCompress.compressVideo(
  //       inputPath,
  //       outputPath,
  //       quality: VideoQuality.mediumQuality, // Adjust quality as needed
  //       deleteOrigin: false // Keep the original file
  //   );
  //
  //   if (result == CompressResult.success) {
  //     return outputPath; // Return the path of the converted video
  //   } else {
  //     // Handle compression errors
  //     print("Compression failed: ${result.toString()}");
  //     return null;
  //   }
  // }


}
