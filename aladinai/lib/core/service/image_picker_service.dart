import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService extends GetxService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickAndCompressImage() async {
    if (kDebugMode) {
      print('[ImagePickerService] Picking image from gallery...');
    }
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        if (kDebugMode) {
          print(
            '[ImagePickerService] Image picked successfully: ${pickedFile.path}',
          );
        }
        return File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('[ImagePickerService] User cancelled image picking.');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('[ImagePickerService] Error picking image: $e');
      }
      Get.snackbar(
        'Error Picking Image',
        'Could not load image from gallery. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }
}
