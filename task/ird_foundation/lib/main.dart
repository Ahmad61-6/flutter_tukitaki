import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart'; // Import the App Widget
 // Import DI

void main() async {
  // 1. Ensure Flutter Bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Dependencies (Repositories, Controllers)
  // await initDependencies();

  // 3. (Optional) Lock Orientation to Portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 4. Run App
  runApp(const RealEstateApp());
}