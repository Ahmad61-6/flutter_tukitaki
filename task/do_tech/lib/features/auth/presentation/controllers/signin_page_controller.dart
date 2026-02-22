import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_helpers.dart';
import '../../../../core/utils/device/device_utils.dart';
import '../../domain/use_cases/user_sign.dart';

class SignInPageController extends GetxController{
  final UserLogin _userLogin;
  SignInPageController({required UserLogin userLogin})
      : _userLogin = userLogin;
  final RxBool _obscureText = true.obs;
  final RxBool _checkBoxValue = false.obs;
  RxBool get checkBoxValue => _checkBoxValue;

  RxBool get obscureText => _obscureText;

  RxBool isLoading = false.obs;

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
  Future<bool> login(
      String email,
      String password,
      BuildContext context,
      ) async {
    isLoading.value = true;
    final params = LoginParams(email: email, password: password);
    final result = await _userLogin.call(params);
    isLoading.value = false;

    return result.fold(
          (failure) {
        DeviceUtility.hideKeyboard(context);
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