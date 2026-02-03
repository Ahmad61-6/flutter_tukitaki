import 'package:clean_arch_blog_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_arch_blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_arch_blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_arch_blog_app/features/auth/domain/usecases/user_sing_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

Future<void> initDependencies() async {
  Get.lazyPut(() => FirebaseAuth.instance);
  Get.lazyPut(() => FirebaseStorage.instance);

  Get.lazyPut<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(Get.find(), Get.find()),
  );

  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
  Get.lazyPut(() => UserSingUp(Get.find()));
}
