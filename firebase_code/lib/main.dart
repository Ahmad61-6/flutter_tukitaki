import 'package:firebase_code/app/modules/splash/screens/splash_screen.dart';
import 'package:firebase_code/controller_binder.dart';
import 'package:firebase_code/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    Get.snackbar(
      'Internal error',
      "Something went wrong in out side. Sorry for the inconvenience.",
    );
    debugPrint("___---___>> Firebase initialization error: $e ___---___>>");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
