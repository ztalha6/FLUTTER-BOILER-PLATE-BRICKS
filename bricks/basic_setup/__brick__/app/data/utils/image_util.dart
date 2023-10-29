import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  /// Converts a base64-encoded string to a [MemoryImage].
  ///
  /// This method decodes the provided base64-encoded string and returns a [MemoryImage]
  /// that contains the decoded image data.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// String base64String = '...'; // Replace with your base64-encoded image string
  /// MemoryImage memoryImage = base64StringToMemoryImage(base64String);
  /// // Use the memoryImage in a Flutter widget.
  /// ```
  ///
  /// Returns a [MemoryImage] containing the decoded image data.
  static MemoryImage base64StringToMemoryImage(String base64String) {
    return MemoryImage(base64Decode(base64String));
  }

  /// Decodes a base64-encoded string to a [Uint8List].
  ///
  /// This method decodes the provided base64-encoded string and returns a [Uint8List]
  /// that contains the decoded binary data.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// String base64String = '...'; // Replace with your base64-encoded string
  /// Uint8List data = fromBase64(base64String);
  /// // Use the 'data' Uint8List as needed.
  /// ```
  ///
  /// Returns a [Uint8List] containing the decoded binary data.
  static Uint8List fromBase64(String base64String) {
    return base64Decode(base64String);
  }

  /// Encodes a [Uint8List] to a base64-encoded string.
  ///
  /// This method encodes the provided [Uint8List] data into a base64-encoded string.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Uint8List data = ...; // Replace with your binary data
  /// String base64String = toBase64(data);
  /// // Use the 'base64String' in your application as needed.
  /// ```
  ///
  /// Returns a base64-encoded string representation of the provided binary data.
  static String toBase64(Uint8List data) {
    return base64Encode(data);
  }

  /// Encodes a [MemoryImage] to a base64-encoded string.
  ///
  /// This method encodes the binary data of the provided [MemoryImage] into a base64-encoded string.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// MemoryImage memoryImage = ...; // Replace with your MemoryImage instance
  /// String base64String = memoryImageToBase64(memoryImage);
  /// // Use the 'base64String' in your application as needed.
  /// ```
  ///
  /// Returns a base64-encoded string representation of the binary data in the provided [MemoryImage].
  static String memoryImageToBase64(MemoryImage memoryImage) {
    return base64Encode(memoryImage.bytes);
  }

  /// Retrieves an image from the device's camera or gallery, optionally cropping it, and returns a [MemoryImage].
  ///
  /// The method utilizes the `image_picker` and `image_cropper` plugins to enable image selection and cropping.
  ///
  /// To use this method, you must have implemented the `image_picker` and `image_cropper` plugins. Add the following
  /// dependencies to your `pubspec.yaml` file:
  ///
  /// ```yaml
  /// dependencies:
  ///   image_picker: ^latest_version
  ///   image_cropper: ^latest_version
  /// ```
  ///
  /// Example usage:
  ///
  /// ```dart
  /// MemoryImage? memoryImage = await getImageFromPhone(camera: true);
  /// if (memoryImage != null) {
  ///   // Use the memoryImage in a Flutter widget.
  /// }
  /// ```
  ///
  /// The optional parameter [camera] determines whether the image is taken from the camera (`true`) or gallery (`false`).
  ///
  /// Returns a [MemoryImage] of the selected and optionally cropped image, or `null` if no image was selected.
  static Future<MemoryImage?> getImageFromPhone({bool camera = false}) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
      );
      if (croppedFile != null) {
        image = XFile(croppedFile.path);
      }
      return MemoryImage(await image.readAsBytes());
    }
    return null;
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
