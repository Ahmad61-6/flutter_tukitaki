import 'package:get/get.dart';
import '../../../../core/helpers/app_helpers.dart';
import '../../domain/usecases/user_login.dart';
import 'app_user_controller.dart';

class LoginScreenController extends GetxController {
  final UserLogin userLogin;
  final AppUserController _appUserController = Get.find();

  final RxBool isLoading = false.obs;
  final RxBool obscureText = true.obs;

  LoginScreenController({required this.userLogin});

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  Future<bool> login(String username, String password) async {
    bool isSuccess = false;
    isLoading.value = true;

    final result = await userLogin.call(
      UserLoginParams(username: username, password: password),
    );

    result.fold(
          (failure) {
        AppHelperFunctions.showSnackBar('Login Failed', failure.message, true);
      },
          (userEntity) {
        _appUserController.setUser(userEntity);
        AppHelperFunctions.showSnackBar(
          'Welcome Back',
          'Hello, ${userEntity.firstName}!',
          false,
        );
        isSuccess = true;
      },
    );

    isLoading.value = false;
    return isSuccess;
  }
}