import 'package:clean_arch_blog_app/features/auth/domain/entities/user.dart';
import 'package:get/get.dart';

class AppUserController extends GetxController {
  final Rx<UserEntity?> user = Rx<UserEntity?>(null);

  void setUser(UserEntity newUser) {
    user.value = newUser;
  }

  bool get isLoggedIn => user.value != null;
}
