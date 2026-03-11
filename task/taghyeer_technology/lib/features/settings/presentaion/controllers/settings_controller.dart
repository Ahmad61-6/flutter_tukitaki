import 'package:get/get.dart';
import '../../../../core/helpers/app_helpers.dart';
import '../../../../routes/app_routes.dart';
import '../../../auth/domain/usecases/user_sign_out.dart';
import '../../../auth/presentation/controllers/app_user_controller.dart';

class SettingsController extends GetxController {
  final UserSignOut userSignOut;
  final AppUserController _appUserController = Get.find();

  SettingsController({required this.userSignOut});

  Future<void> logOut() async {
    final result = await userSignOut.call();

    result.fold(
          (failure) {
        AppHelperFunctions.showSnackBar('Logout Failed', failure.message, true);
      },
          (_) {
        _appUserController.clearUser();
        Get.offAllNamed(AppRoutes.loginScreen);
      },
    );
  }
}