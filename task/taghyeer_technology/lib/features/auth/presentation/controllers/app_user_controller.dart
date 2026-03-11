import 'package:get/get.dart';
import '../../domain/entities/user_entity.dart';

class AppUserController extends GetxController {
  final Rxn<UserEntity> currentUser = Rxn<UserEntity>();

  bool get isLoggedIn => currentUser.value != null;

  void setUser(UserEntity user) {
    currentUser.value = user;
  }

  void clearUser() {
    currentUser.value = null;
  }
}