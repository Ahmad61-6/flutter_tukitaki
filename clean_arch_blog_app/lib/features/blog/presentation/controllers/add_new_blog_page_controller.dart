import 'dart:io';

import 'package:clean_arch_blog_app/core/helpers/app_helper.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/controllers/app_user_controller.dart';
import 'package:clean_arch_blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewBlogPageController extends GetxController {
  final UploadBlog _uploadBlog;
  final AppUserController _appUserController;

  AddNewBlogPageController({
    required UploadBlog uploadBlog,
    required AppUserController appUserController,
  }) : _uploadBlog = uploadBlog,
       _appUserController = appUserController;

  final RxList<String> _selectedCategories = <String>[].obs;
  final Rx<File?> _selectedImage = Rx<File?>(null);
  final RxBool _isLoading = false.obs;

  RxBool get isLoading => _isLoading;

  RxList<String> get selectedCategories => _selectedCategories;

  Rx<File?> get selectedImage => _selectedImage;

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

  // Helper to clear non-text fields (Image & Categories)
  void clearState() {
    _selectedImage.value = null;
    _selectedCategories.clear();
    _isLoading.value = false;
  }

  Future<bool> uploadBlog(String title, String content) async {
    // 1. Validation Logic
    if (_selectedImage.value == null) {
      AppHelperFunctions.showSnackBar(
        "Warning",
        "Please select an image",
        true,
      );
      return false;
    }
    if (_selectedCategories.isEmpty) {
      AppHelperFunctions.showSnackBar(
        "Warning",
        "Please select at least one category",
        true,
      );
      return false;
    }

    // Safety check for user
    if (_appUserController.user.value == null) {
      AppHelperFunctions.showSnackBar("Error", "User not logged in", true);
      return false;
    }

    _isLoading.value = true;
    final String posterId = _appUserController.user.value!.uId;

    final params = UploadBlogParams(
      posterId: posterId,
      title: title,
      content: content,
      image: _selectedImage.value!,
      categories: _selectedCategories,
    );

    final result = await _uploadBlog.call(params);
    _isLoading.value = false;

    return result.fold(
      (failure) {
        AppHelperFunctions.showSnackBar("Upload Failed", failure.message, true);
        return false;
      },
      (blog) {
        AppHelperFunctions.showSnackBar(
          "Success",
          "Blog uploaded successfully!",
          false,
        );
        clearState();
        return true;
      },
    );
  }
}
