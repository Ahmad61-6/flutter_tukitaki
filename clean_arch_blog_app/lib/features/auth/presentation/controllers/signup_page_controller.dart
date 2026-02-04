import 'dart:io';

import 'package:clean_arch_blog_app/core/helpers/app_helper.dart';
import 'package:clean_arch_blog_app/features/auth/domain/usecases/user_sing_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupPageController extends GetxController {
  final UserSingUp _userSingUp;

  SignupPageController({required UserSingUp userSingUp})
    : _userSingUp = userSingUp;

  final RxBool isLoading = false.obs;

  final RxBool _obscureText1 = true.obs;

  RxBool get obscureText1 => _obscureText1;

  final RxBool _obscureText2 = true.obs;

  RxBool get obscureText2 => _obscureText2;

  final Rx<File?> _selectedImage = Rx<File?>(null);

  Rx<File?> get selectedImage => _selectedImage;

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        _selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<bool> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    isLoading.value = true;
    final params = SignUpParams(
      name: name,
      email: email,
      password: password,
      image: image,
    );
    final result = await _userSingUp.call(params);
    isLoading.value = false;

    return result.fold(
      (failure) {
        AppHelperFunctions.showSnackBar(
          "Sign Up failed",
          failure.message,
          true,
        );
        debugPrint("xxxxxxx ${failure.message} xxxxxxx");
        return false;
      },
      (user) {
        AppHelperFunctions.showSnackBar("Sign Up successful", user.name, false);
        return true;
      },
    );
  }

  void changeVisibility(int fieldNo) {
    if (fieldNo == 1) {
      _obscureText1.value = !_obscureText1.value;
    } else {
      _obscureText2.value = !_obscureText2.value;
    }
  }

  void resetVisibility() {
    _obscureText1.value = true;
    _obscureText2.value = true;
  }
}
