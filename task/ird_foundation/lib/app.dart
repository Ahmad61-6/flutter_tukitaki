import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ird_foundation/screens/home_screen.dart';
import 'package:ird_foundation/screens/main_dashboard.dart';



import 'core/utils/sizer.dart';


class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Real Estate App',

          // theme: AppTheme.lightTheme,
          home: const MainDashboard(),
        );
      },
    );
  }
}