import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_helpers.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/common/controllers/auth_controller.dart';

class SignOutController extends GetxController {

  RxBool isLoading = false.obs;

  Future<void> signOut() async {
    isLoading.value = true;
    debugPrint("------->> Signing out user <<-------");

    try {
      final authController = Get.find<AuthController>();

      await authController.clearUserData();

      isLoading.value = false;


      AppHelperFunctions.showSnackBar(
        "Sign Out successful",
        "You have been successfully signed out",
        false,
      );

      Get.offAllNamed(AppRoutes.signInPage);

    } catch (e) {
      isLoading.value = false;
      debugPrint("xxxxxxx Sign Out Error: $e xxxxxxx");

      AppHelperFunctions.showSnackBar(
        "Sign Out failed",
        "An unexpected error occurred. Please try again.",
        true,
      );
    }
  }
}