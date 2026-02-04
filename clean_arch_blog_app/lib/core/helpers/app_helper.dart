import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AppHelperFunctions {
  AppHelperFunctions._();

  static void showSnackBar(String title, String message, bool isFailure) {
    Get.closeCurrentSnackbar();
    Get.snackbar(
      title,
      message,
      backgroundColor: isFailure ? Colors.redAccent : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
