import 'package:taghyeer_technology/core/network/urls/api_urls.dart';

import '../../../../core/network/network_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login({required String username, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkClient _networkClient;

  AuthRemoteDataSourceImpl(this._networkClient);

  @override
  Future<UserModel> login({required String username, required String password}) async {
    final body = {
      "username": username,
      "password": password,
      "expiresInMins": 30
    };

    final response = await _networkClient.postRequest(ApiUrls.login, body: body);

    if (response.isSuccess && response.responseData != null) {
      return UserModel.fromJson(response.responseData!);
    } else {
      throw ServerException(response.errorMessage ?? 'Login failed');
    }
  }
}