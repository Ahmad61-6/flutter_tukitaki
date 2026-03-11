

import 'package:get/get.dart';
import 'package:taghyeer_technology/features/auth/presentation/controllers/login_screen_controller.dart';
import 'package:taghyeer_technology/features/common/main_nav/presentation/controllers/main_bottom_nav_controller.dart';
import 'package:taghyeer_technology/features/product/presentation/controllers/product_controller.dart';

import '../../features/auth/presentation/controllers/app_user_controller.dart';
import '../../features/auth/presentation/controllers/splash_screen_controller.dart';
import '../../features/post/presentation/controllers/post_controller.dart';
import '../../features/settings/presentaion/controllers/settings_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {

    Get.put(AppUserController(), permanent: true);
    Get.put(LoginScreenController(userLogin: Get.find()));
    Get.put(SplashScreenController(Get.find()));
    Get.put(MainBottomNavController(),permanent: true);
    Get.put(ProductController(getProductsUseCase: Get.find()));
    Get.lazyPut(() => PostController(getPostsUseCase: Get.find()), fenix: true);
    Get.lazyPut(() => SettingsController(userSignOut: Get.find()), fenix: true);
  }
}
