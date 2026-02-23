import 'package:do_tech/core/common/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Adjust these imports based on your folder structure
import '../../../../core/common/db/mock_backend.dart';
import '../../../../core/helpers/app_helpers.dart';
import '../../../../core/utils/device/device_utils.dart';
import '../../../shared/data/models/user_model.dart';
import '../../data/models/login_request_model.dart';


class SignInPageController extends GetxController {
  final RxBool _obscureText = true.obs;
  final RxBool _checkBoxValue = false.obs;

  RxBool get checkBoxValue => _checkBoxValue;
  RxBool get obscureText => _obscureText;
  RxBool isLoading = false.obs;

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

  Future<bool> login(String email, String password, BuildContext context) async {
    isLoading.value = true;
    _errorMessage = null;

    try {
      final Map<String, dynamic> response = await MockBackend.login(email, password);

      if (response['isSuccess'] == true) {
        final userModel = UserModel.fromJson(response['data']['user']);
        final token = response['data']['token'];

        await Get.find<AuthController>().saveUserData(userModel, token);

        isLoading.value = false;

        AppHelperFunctions.showSnackBar("Success", "Welcome back, ${userModel.username}", false);
        return true;
      } else {
        _errorMessage = response['msg'];
        DeviceUtility.hideKeyboard(context);
        AppHelperFunctions.showSnackBar("Login failed", _errorMessage ?? "Unknown Error", true);
        return false;
      }
    } catch (e) {
      _errorMessage = "An unexpected error occurred.";
      isLoading.value = false;
      return false;
    }
  }
}