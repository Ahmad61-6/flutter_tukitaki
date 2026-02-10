import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  static Future<File?> pickImage() async {
    try {
      final XFile? xFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (xFile != null) {
        return File(xFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static int calculateReadingTime(String content) {
    final wordCount = content.split(RegExp(r'\s+')).length;
    final readingTime = (wordCount / 225).ceil();
    return readingTime;
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('d MMM, yyyy - h:mm a').format(date);
  }
}
