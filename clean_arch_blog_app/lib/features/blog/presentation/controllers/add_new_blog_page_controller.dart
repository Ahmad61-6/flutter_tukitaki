import 'dart:io';

import 'package:clean_arch_blog_app/core/helpers/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewBlogPageController extends GetxController {
  final RxInt _selectedCategoryIndex = 0.obs;
  final RxList<String> _selectedCategories = <String>[].obs;
  final Rx<File?> _selectedImage = Rx<File?>(null);

  RxInt get selectedCategoryIndex => _selectedCategoryIndex;

  RxList<String> get selectedCategories => _selectedCategories;

  Rx<File?> get selectedImage => _selectedImage;

  void changeBlogCategory(int index) {
    if (index != _selectedCategoryIndex.value) {
      _selectedCategoryIndex.value = index;
    } else {
      return;
    }
  }

  void selectedCategoryItems(String item) {
    if (_selectedCategories.contains(item)) {
      _selectedCategories.remove(item);
    } else {
      _selectedCategories.add(item);
    }
  }

  void selectImage() async {
    try {
      final pickedImage = await AppHelperFunctions.pickImage();
      if (pickedImage != null) {
        _selectedImage.value = pickedImage;
      }
    } catch (e) {
      debugPrint("xxxxxxx ${e.toString()} xxxxxxx");
      AppHelperFunctions.showSnackBar(
        "Image selection failed",
        e.toString(),
        true,
      );
    }
  }

  void removeImage() {
    _selectedImage.value = null;
  }
}
