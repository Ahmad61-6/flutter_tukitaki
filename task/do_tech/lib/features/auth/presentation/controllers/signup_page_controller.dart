import 'package:do_tech/core/common/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/common/db/mock_backend.dart';
import '../../../../core/helpers/app_helpers.dart';
import '../../../../core/utils/device/device_utils.dart';
import '../../../shared/data/models/user_model.dart';


class SignupPageController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool _obscureText = true.obs;
  final RxBool _checkBoxValue = false.obs;

  RxBool get checkBoxValue => _checkBoxValue;
  RxBool get obscureText => _obscureText;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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

  Future<bool> signUp(String name, String email, String password, BuildContext context) async {
    isLoading.value = true;
    _errorMessage = null;

    try {
      final response = await MockBackend.signup(name, email, password);

      if (response['isSuccess'] == true) {
        final userModel = UserModel.fromJson(response['data']['user']);
        final token = response['data']['token'];

        await Get.find<AuthController>().saveUserData(userModel, token);

        isLoading.value = false;
        return true;
      } else {
        _errorMessage = response['msg'];
        DeviceUtility.hideKeyboard(context);
        AppHelperFunctions.showSnackBar("Sign Up Failed", _errorMessage!, true);
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      _errorMessage = "An unexpected error occurred.";
      isLoading.value = false;
      return false;
    }
  }
}