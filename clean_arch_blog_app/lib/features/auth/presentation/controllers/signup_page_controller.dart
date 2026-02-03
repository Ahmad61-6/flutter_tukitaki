import 'package:clean_arch_blog_app/features/auth/domain/usecases/user_sing_up.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignupPageController extends GetxController {
  final UserSingUp _userSingUp;

  SignupPageController({required UserSingUp userSingUp})
      : _userSingUp = userSingUp;

  final RxBool _obscureText1 = true.obs;

  RxBool get obscureText1 => _obscureText1;

  final RxBool _obscureText2 = true.obs;

  RxBool get obscureText2 => _obscureText2;

  void changeVisibility(int fieldNo) {
    if (fieldNo == 1) {
      _obscureText1.value = !_obscureText1.value;
    } else {
      _obscureText2.value = !_obscureText2.value;
    }
  }

  void resetVisibility() {
    _obscureText1.value = true;
    _obscureText2.value = true;
    
  }
}
