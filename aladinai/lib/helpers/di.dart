import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/controllers/theme_controller.dart';

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs);

  await Get.putAsync(() async => ThemeController());
}
