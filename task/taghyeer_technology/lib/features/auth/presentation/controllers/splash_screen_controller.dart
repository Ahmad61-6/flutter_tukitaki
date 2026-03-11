import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../auth/domain/usecases/check_cached_user.dart';
import 'app_user_controller.dart';

class SplashScreenController extends GetxController {
  final CheckCachedUser _checkCachedUser;

  final AppUserController _appUserController = Get.find();

  SplashScreenController(this._checkCachedUser);

  @override
  void onReady() {
    super.onReady();
    _handleAutoLogin();
  }

  Future<void> _handleAutoLogin() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    final result = await _checkCachedUser.call();

    result.fold(
          (failure) {
        Get.offAllNamed(AppRoutes.loginScreen);
      },
          (userEntity) {

        _appUserController.setUser(userEntity);

        // Get.offAllNamed(AppRoutes.loginScreen);
      },
    );
  }
}