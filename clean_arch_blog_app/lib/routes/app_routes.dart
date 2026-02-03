import 'package:clean_arch_blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/pages/signup_page.dart';

class AppRoutes {
  static String loginPage = "/loginPage";
  static String signupPage = "/signupPage";
  static String init = "/";


  static List<GetPage> routes = [
    GetPage(name: loginPage,page: () => const LoginPage()),
    GetPage(name: signupPage,page: () => const SignupPage()),

  ];
}