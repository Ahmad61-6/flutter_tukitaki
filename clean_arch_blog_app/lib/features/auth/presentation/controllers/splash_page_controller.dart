import 'package:clean_arch_blog_app/features/auth/domain/usecases/get_auth_state.dart';
import 'package:clean_arch_blog_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:clean_arch_blog_app/features/auth/domain/usecases/sign_out.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/controllers/app_user_controller.dart';
import 'package:clean_arch_blog_app/routes/app_routes.dart';
import 'package:get/get.dart';

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
          Get.offAllNamed(AppRoutes.loginPage);
        },
        (userEntity) {
          _appUserController.setUser(userEntity);
          Get.offAllNamed(AppRoutes.blogPage);
        },
      );
    });
  }
}
