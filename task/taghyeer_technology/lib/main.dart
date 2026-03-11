import 'package:flutter/cupertino.dart';
import 'package:taghyeer_technology/app.dart';
import 'package:taghyeer_technology/core/di/dependency_injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MyApp());

}