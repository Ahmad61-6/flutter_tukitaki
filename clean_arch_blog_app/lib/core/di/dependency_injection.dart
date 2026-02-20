import 'package:clean_arch_blog_app/core/network/connection_checker.dart';
import 'package:clean_arch_blog_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_arch_blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_arch_blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_arch_blog_app/features/auth/domain/usecases/get_auth_state.dart';
import 'package:clean_arch_blog_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:clean_arch_blog_app/features/auth/domain/usecases/sign_out.dart';
import 'package:clean_arch_blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:clean_arch_blog_app/features/auth/domain/usecases/user_sing_up.dart';
import 'package:clean_arch_blog_app/features/blog/data/data_source/blog_remote_data_sources.dart';
import 'package:clean_arch_blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:clean_arch_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_arch_blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:clean_arch_blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

Future<void> initDependencies() async {
  Get.lazyPut(() => FirebaseAuth.instance);
  Get.lazyPut(() => FirebaseStorage.instance);
  Get.lazyPut(() => FirebaseFirestore.instance);
  Get.put(InternetConnection());

  Get.lazyPut<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(Get.find(), Get.find(), Get.find()),
  );
  Get.lazyPut<BlogRemoteDataSources>(
    () => BlogRemoteDataSourcesImpl(Get.find(), Get.find()),
  );
  Get.lazyPut<ConnectionChecker>(() => ConnectionCheckerImpl(Get.find()));

  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find(), Get.find()));
  Get.lazyPut<BlogRepository>(() => BlogRepositoryImpl(Get.find()));
  Get.lazyPut(() => UserSingUp(Get.find()));
  Get.lazyPut(() => UserLogin(Get.find()));
  Get.lazyPut(() => GetCurrentUser(Get.find()));
  Get.lazyPut(() => GetAuthState(Get.find()));
  Get.lazyPut(() => UploadBlog(Get.find()));
  Get.lazyPut(() => GetAllBlogs(Get.find()));
  Get.lazyPut(() => UserSignOut(Get.find()));
}
