import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
class ImageConvertHelper{

// static   Future<String?> pickAndConvertImage(String inputPath,) async {
//      try {
//        if(!inputPath.toLowerCase().endsWith('.png')){
//          final File inputFile = File(inputPath);
//          final List<int> imageBytes = await inputFile.readAsBytes();
//          final img.Image? originalImage = img.decodeImage(Uint8List.fromList(imageBytes));
//          final outputPath = path.setExtension(inputPath, '.png');
//          if (originalImage != null) {
//            // Convert the image to PNG
//            final List<int> pngBytes = img.encodePng(originalImage);
//            // Save the converted image to the specified output path
//            final File outputFile = File(outputPath);
//            await outputFile.writeAsBytes(pngBytes);
//            // Return the output path
//            return outputFile.path;
//          }
//        } else{
//          return inputPath;
//        }
//        // Load the image using the image package
//      } catch (e) {
//        print('Error: $e');
//      }
//
//     return null;
//   }

static  Future<Uint8List?> compressAndTryCatch(String path) async {
    Uint8List? result;
    try {
      result = await FlutterImageCompress.compressWithFile(
        path,
        format: CompressFormat.png,
      );
    } on UnsupportedError catch (e) {
      print(e);
      result = await FlutterImageCompress.compressWithFile(
        path,
        format: CompressFormat.png,
      );
    }
    return result;
  }
static Future<String?> convertToPng(String inputFilePath) async {
  try {
    debugPrint("====> image path input convert png $inputFilePath");
    // Check if the file exists
    File inputFile = File(inputFilePath);
    if (!inputFile.existsSync()) {
      print('Input file not found at: $inputFilePath');
      return null;
    }

    // Read input image
    Uint8List inputBytes = await inputFile.readAsBytes();
    img.Image? inputImage = img.decodeImage(inputBytes);

    if (inputImage == null) {
      print('Failed to decode input image.');
      return null;
    }

    // Convert to PNG
    img.Image pngImage = img.copyResize(inputImage, width: 300); // Adjust width as needed

    // Get the documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String pngFilePath =path.join(documentsDirectory.path, 'converted_image.png');

    // Save PNG image
    File(pngFilePath).writeAsBytesSync(img.encodePng(pngImage));

    print('Image converted and saved at: $pngFilePath');
    return pngFilePath;
  } catch (e) {
    print('Error converting to PNG: $e');
    return null;
  }
}

static Future<String?> convertHeifHeicToPng(String heifHeicFilePath) async {
  try {
    // Check if the file exists
    File heifHeicFile = File(heifHeicFilePath);
    if (!heifHeicFile.existsSync()) {
      print('HEIF/HEIC file not found at: $heifHeicFilePath');
      return null;
    }

    // Read HEIF/HEIC image
    Uint8List heifHeicBytes = await heifHeicFile.readAsBytes();
    img.Image? heifHeicImage = img.decodeImage(heifHeicBytes);

    if (heifHeicImage == null) {
      print('Failed to decode HEIF/HEIC image.');
      return null;
    }

    // Convert to PNG
    img.Image pngImage = img.copyResize(heifHeicImage, width: 300); // Adjust width as needed

    // Get the documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String pngFilePath = path.join(documentsDirectory.path, 'converted_image.png');

    // Save PNG image
    File(pngFilePath).writeAsBytesSync(img.encodePng(pngImage));

    print('Image converted and saved at: $pngFilePath');
    return pngFilePath;
  } catch (e) {
    print('Error converting HEIF/HEIC to PNG: $e');
    return null;
  }
}

// static Future<String> convertImage(String filePath) async {
//   try {
//     // Extract the base path and filename
//     final basename = path.basenameWithoutExtension(filePath);
//     final outputPath = path.join(path.dirname(filePath), '$basename.png');
//
//     // Load the image bytes
//     final bytes = await File(filePath).readAsBytes();
//
//     // Decode the image based on its format
//     img.Image image;
//     if (filePath.toLowerCase().endsWith('.heic')) {
//       // Use HEIF library for decoding
//       image = img.Image.fromBytes(await HeicDecoder().decodeImage(bytes));
//     } else {
//       // Use image package for other formats
//       image = img.decodeImage(bytes);
//     }
//
//     // Encode as PNG
//     final pngBytes = img.encodePng(image);
//
//     // Save the PNG image
//     await File(outputPath).writeAsBytes(pngBytes);
//
//     print('Image converted to PNG successfully!');
//     return outputPath;
//   } catch (error) {
//     print('Error converting image: $error');
//     return null; // Or throw an exception if desired
//   }
// }
}