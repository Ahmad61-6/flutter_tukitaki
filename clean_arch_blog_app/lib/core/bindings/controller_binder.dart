import 'package:clean_arch_blog_app/features/auth/presentation/controllers/app_user_controller.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/controllers/signup_page_controller.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/controllers/splash_page_controller.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/controllers/login_screen_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    // Get.put(LoginScreenController());
    // Get.put(SignupPageController());

    Get.put(SignupPageController(userSingUp: Get.find()));
    Get.put(LoginScreenController(userLogin: Get.find()));
    Get.put(AppUserController());
    Get.put(AppUserController());
    Get.put(SplashScreenController(Get.find(), Get.find()));
  }
}
