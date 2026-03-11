import 'package:get/get.dart';
import 'package:taghyeer_technology/features/auth/presentation/screens/login_screen.dart';
import 'package:taghyeer_technology/features/common/main_nav/presentation/screens/main_navigation_screen.dart';
import 'package:taghyeer_technology/features/post/presentation/screens/post_details_screen.dart';
import 'package:taghyeer_technology/features/product/presentation/screens/product_details_screen.dart';
import 'package:taghyeer_technology/features/product/presentation/screens/products_screen.dart';

import '../features/auth/presentation/screens/splash_screen.dart';

class AppRoutes {
  static String loginScreen = "/loginScreen";
  static String productScreen = "/productScreen";
  static String postScreen = "/postScreen";
  static String settingsScreen = "/settingsScreen";
  static String mainBottomNav = "/mainBottomNav";
  static String init = "/";

  static String productDetails = "/productDetails";
  static String postDetails = "/postDetails";


  static List<GetPage> routes = [
    GetPage(name: init, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: ()=> const LoginScreen()),
    GetPage(name: mainBottomNav, page: ()=> const MainNavigationScreen()),
    GetPage(name: productScreen, page:()=> const ProductsScreen() ),
    GetPage(name: productDetails, page: ()=> ProductDetailsScreen()),
    GetPage(name: postDetails, page: ()=> PostDetailsScreen()),


  ];
}
