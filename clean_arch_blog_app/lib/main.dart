import 'package:clean_arch_blog_app/app.dart';
import 'package:clean_arch_blog_app/core/di/dependency_injection.dart';
import 'package:clean_arch_blog_app/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    providerAndroid: AndroidDebugProvider(),
    providerApple: AppleDebugProvider(),
  );
  await initDependencies();
  runApp(BlogApp());
}
