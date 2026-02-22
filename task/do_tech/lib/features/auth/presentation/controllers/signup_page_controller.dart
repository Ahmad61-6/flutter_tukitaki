import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_helpers.dart';
import '../../domain/use_cases/user_signup.dart';

class SignupPageController extends GetxController{
  final UserSingUp _userSingUp;

  SignupPageController({required UserSingUp userSingUp})
      : _userSingUp = userSingUp;
  final RxBool isLoading = false.obs;

  final RxBool _obscureText = true.obs;
  final RxBool _checkBoxValue = false.obs;
  RxBool get checkBoxValue => _checkBoxValue;

  RxBool get obscureText => _obscureText;


  void passwordVisibility() {
    _obscureText.value = !_obscureText.value;
  }
  void checkBoxVisibility(bool? value) {
    if (value != null) {
      _checkBoxValue.value = value;
    }
  }

  void resetVisibility() {

    _obscureText.value = true;
  }
  Future<bool> signUp(
      String name,
      String email,
      String password,
      ) async {
    isLoading.value = true;
    final params = SignUpParams(
      name: name,
      email: email,
      password: password,

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
}