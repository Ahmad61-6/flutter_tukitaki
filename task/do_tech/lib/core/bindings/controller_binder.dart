import 'package:do_tech/features/auth/presentation/controllers/signup_page_controller.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/controllers/app_user_controller.dart';
import '../../features/auth/presentation/controllers/sign_out_controller.dart';
import '../../features/auth/presentation/controllers/signin_page_controller.dart';
import '../../features/auth/presentation/controllers/splash_page_controller.dart';

class ControllerBinder  extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SignInPageController(userLogin: Get.find()));
    Get.put(SignupPageController(userSingUp: Get.find()));
    Get.put(SignOutController(userSignOut: Get.find()));
    Get.put(AppUserController(), permanent: true);
    Get.put(SplashScreenController(Get.find(), Get.find()));

  }
}