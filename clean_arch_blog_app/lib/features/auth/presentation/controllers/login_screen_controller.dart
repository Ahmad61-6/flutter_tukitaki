import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  final RxBool _obscureText = true.obs;

  RxBool get obscureText => _obscureText;

  void passwordVisibility() {
    _obscureText.value = !_obscureText.value;
  }

  void resetVisibility() {
    _obscureText.value = true;
  }
}
