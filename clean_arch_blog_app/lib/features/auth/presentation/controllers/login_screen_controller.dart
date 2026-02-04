import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_helper.dart';
import '../../domain/usecases/user_login.dart';

class LoginScreenController extends GetxController {
  final UserLogin _userLogin;

  LoginScreenController({required UserLogin userLogin})
    : _userLogin = userLogin;

  final RxBool _obscureText = true.obs;

  RxBool get obscureText => _obscureText;

  RxBool isLoading = false.obs;

  void passwordVisibility() {
    _obscureText.value = !_obscureText.value;
  }

  void resetVisibility() {
    _obscureText.value = true;
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    final params = LoginParams(email: email, password: password);
    final result = await _userLogin.call(params);
    isLoading.value = false;

    return result.fold(
      (failure) {
        AppHelperFunctions.showSnackBar("Login failed", failure.message, true);
        debugPrint("xxxxxxx ${failure.message} xxxxxxx");
        return false;
      },
      (user) {
        AppHelperFunctions.showSnackBar("Login successful", user.name, false);
        return true;
      },
    );
  }
}
