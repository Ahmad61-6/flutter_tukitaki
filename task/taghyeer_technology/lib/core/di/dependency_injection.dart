

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taghyeer_technology/features/auth/domain/usecases/user_login.dart';
import 'package:taghyeer_technology/routes/app_routes.dart';

import '../../features/auth/data/data_sources/auth_local_data_source.dart';
import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/check_cached_user.dart';
import '../../features/auth/domain/usecases/user_sign_out.dart';
import '../../features/common/main_nav/presentation/controllers/main_bottom_nav_controller.dart';
import '../../features/post/data/data_sources/post_remote_data_source.dart';
import '../../features/post/data/repositories/post_repository_impl.dart';
import '../../features/post/domain/repositories/post_repository.dart';
import '../../features/post/domain/usecases/get_posts.dart';
import '../../features/product/data/data_sources/product_remote_data_source.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/usecases/get_products.dart';
import '../../features/product/presentation/controllers/product_controller.dart';
import '../network/connection/connection_checker.dart';
import '../network/network_client.dart';
import '../theme/controller/theme_controller.dart';

Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPrefs, permanent: true);
  Get.lazyPut(() => Connectivity(), fenix: true);

  Get.put(ThemeController(Get.find()), permanent: true);

  Get.lazyPut<ConnectionChecker>(() => ConnectionCheckerImpl(Get.find()), fenix: true);
  Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(Get.find()), fenix: true);

  Get.lazyPut<NetworkClient>(() => NetworkClient(
    onUnAuthorize: () {
      Get.find<AuthLocalDataSource>().clearCachedUserData();
      Get.offAllNamed(AppRoutes.loginScreen);
    },
  ), fenix: true);

  Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(Get.find()), fenix: true);

  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(
    Get.find<AuthRemoteDataSource>(),
    Get.find<AuthLocalDataSource>(),
    Get.find<ConnectionChecker>(),
  ), fenix: true);

  Get.lazyPut(() => UserLogin(Get.find()), fenix: true);
  Get.lazyPut(() => CheckCachedUser(Get.find()), fenix: true);
  Get.lazyPut(() => UserSignOut(Get.find()), fenix: true);


  Get.lazyPut<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(Get.find()),
    fenix: true,
  );

  Get.lazyPut<ProductRepository>(
        () => ProductRepositoryImpl(Get.find(), Get.find()),
    fenix: true,
  );

  Get.lazyPut(() => GetProducts(Get.find()), fenix: true);


  Get.lazyPut<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(Get.find()), fenix: true);
  Get.lazyPut<PostRepository>(() => PostRepositoryImpl(Get.find(), Get.find()), fenix: true);
  Get.lazyPut(() => GetPosts(Get.find()), fenix: true);
}