
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


import '../../../../core/helpers/app_helpers.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/use_cases/sign_out.dart';

class SignOutController extends GetxController {
  final UserSignOut _userSignOut;

  SignOutController({required UserSignOut userSignOut})
      : _userSignOut = userSignOut;

  RxBool isLoading = false.obs;

  Future<void> signOut() async {
    isLoading.value = true;
    debugPrint("------->> Signing out user <<-------");

    final result = await _userSignOut.call(NoParams());

    result.fold(
          (failure) {
        isLoading.value = false;
        AppHelperFunctions.showSnackBar(
          "Sign Out failed",
          failure.message,
          true,
        );
        debugPrint("xxxxxxx ${failure.message} xxxxxxx");
      },
          (success) {
        isLoading.value = false;
        AppHelperFunctions.showSnackBar(
          "Sign Out successful",
          "You have been successfully signed out",
          false,
        );
        Get.offAllNamed(AppRoutes.init);
      },
    );
  }
}
