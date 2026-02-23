import 'package:do_tech/features/auth/presentation/controllers/signup_page_controller.dart';
import 'package:do_tech/features/home/presentation/controllers/home_controller.dart';
import 'package:do_tech/features/shared/presentation/controllers/bottom_nav_controller.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/controllers/sign_out_controller.dart';
import '../../features/auth/presentation/controllers/signin_page_controller.dart';
import '../common/controllers/auth_controller.dart';

class ControllerBinder  extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AuthController());
    Get.put(SignInPageController());
    Get.put(SignupPageController());
    Get.put(SignOutController());
    Get.put(MainNavController());

  }
}