import 'package:clean_arch_blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/pages/splash_page.dart';
import 'package:clean_arch_blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/pages/signup_page.dart';
import '../features/blog/presentation/pages/add_new_blog_page.dart';
import '../features/blog/presentation/pages/home_page.dart';

class AppRoutes {
  static String loginPage = "/loginPage";
  static String signupPage = "/signupPage";
  static String homePage = "/homePage";
  static String init = "/";

  static String blogPage = '/blogPage';
  static String addNewBlogPage = '/addNewBlogPage';

  static List<GetPage> routes = [
    GetPage(name: loginPage, page: () => const LoginPage()),
    GetPage(name: signupPage, page: () => const SignupPage()),
    GetPage(name: homePage, page: () => const HomePage()),
    GetPage(name: init, page: () => const SplashPage()),

    GetPage(name: blogPage, page: () => const BlogPage()),
    GetPage(name: addNewBlogPage, page: () => const AddNewBlogPage()),
  ];
}
