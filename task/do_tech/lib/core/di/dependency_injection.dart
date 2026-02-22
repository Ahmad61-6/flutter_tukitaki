import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/get_auth_state.dart';
import '../../features/auth/domain/use_cases/get_current_user.dart';
import '../../features/auth/domain/use_cases/sign_out.dart';
import '../../features/auth/domain/use_cases/user_sign.dart';
import '../../features/auth/domain/use_cases/user_signup.dart';
import '../network/internet_checker.dart';

Future<void> initDependencies() async{
  Get.lazyPut(() => FirebaseAuth.instance);
  Get.lazyPut(() => FirebaseFirestore.instance);
  Get.put(InternetConnection());

  Get.lazyPut<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(Get.find(), Get.find()),
  );
  Get.lazyPut<ConnectionChecker>(() => ConnectionCheckerImpl(Get.find()));
  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find(), Get.find()));
  Get.lazyPut(() => UserSingUp(Get.find()));
  Get.lazyPut(() => UserLogin(Get.find()));
  Get.lazyPut(() => GetCurrentUser(Get.find()));
  Get.lazyPut(() => GetAuthState(Get.find()));
  Get.lazyPut(() => UserSignOut(Get.find()));


}