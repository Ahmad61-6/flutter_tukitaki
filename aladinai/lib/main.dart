import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'app/utils/app_version_service.dart';
import 'helpers/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AppVersionService.getCurrentAppVersion();
  runApp(App());
}
