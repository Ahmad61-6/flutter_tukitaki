import 'package:get/get.dart';

import '../../domain/entities/user_entity.dart';

class AppUserController extends GetxController {
  final Rx<UserEntity?> user = Rx<UserEntity?>(null);

  void setUser(UserEntity newUser) {
    user.value = newUser;
  }

  bool get isLoggedIn => user.value != null;
}
