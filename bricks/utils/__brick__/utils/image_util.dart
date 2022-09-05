import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageUtil {
  static MemoryImage imageFromBase64String(String base64String) {
    return MemoryImage(base64Decode(base64String));
  }

  static Uint8List fromBase64(String base64String) {
    return base64Decode(base64String);
  }

  static String toBase64(Uint8List data) {
    return base64Encode(data);
  }

  // static Future<List<String>> getPathsFromEncodedImages(
  //     List<String> encodedImages) async {
  //   List<String> paths = [];
  //   for (int i = 0; i < encodedImages.length; i++) {
  //     Directory tempDir = await getTemporaryDirectory();
  //     String tempPath = tempDir.path;
  //     Uint8List bytes = fromBase64(encodedImages[i]);
  //     File file = File("$tempPath/" +
  //         DateTime.now().millisecondsSinceEpoch.toString() +
  //         ".png");
  //     await file.writeAsBytes(bytes);
  //     paths.add(file.path);
  //   }
  //   return paths;
  // }
}
