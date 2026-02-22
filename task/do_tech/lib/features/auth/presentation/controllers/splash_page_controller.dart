
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../domain/use_cases/get_auth_state.dart';
import '../../domain/use_cases/get_current_user.dart';
import '../../domain/use_cases/sign_out.dart';
import 'app_user_controller.dart';

class SplashScreenController extends GetxController {
  final GetAuthState _getAuthState;
  final GetCurrentUser _currentUser;
  final AppUserController _appUserController = Get.find();

  SplashScreenController(this._getAuthState, this._currentUser);

  @override
  void onReady() {
    super.onReady();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    _getAuthState.call().first.then((user) async {
      final result = await _currentUser.call(NoParams());

      result.fold(
            (failure) {
          Get.offAllNamed(AppRoutes.signInPage);
        },
            (userEntity) {
          _appUserController.setUser(userEntity);
          // Get.offAllNamed(AppRoutes.blogPage);
        },
      );
    });
  }
}
