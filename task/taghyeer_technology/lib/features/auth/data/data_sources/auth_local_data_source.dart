import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';

abstract interface class AuthLocalDataSource {
  Future<void> cacheUserData(UserModel user);
  Future<UserModel> getCachedUserData();
  Future<void> clearCachedUserData();
  Future<void> updateTokens(String newAccessToken, String newRefreshToken);

  String? get accessToken;
  String? get refreshToken;
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _userDataKey = 'user-data';
  static const String _accessTokenKey = 'access-token';
  static const String _refreshTokenKey = 'refresh-token';


  String? _accessToken;
  String? _refreshToken;
  UserModel? _userModel;

  AuthLocalDataSourceImpl(this.sharedPreferences) {
    _loadIntoMemory();
  }

  void _loadIntoMemory() {
    _accessToken = sharedPreferences.getString(_accessTokenKey);
    _refreshToken = sharedPreferences.getString(_refreshTokenKey);
    final userData = sharedPreferences.getString(_userDataKey);
    if (userData != null) {
      _userModel = UserModel.fromJson(json.decode(userData));
    }
  }

  @override
  String? get accessToken => _accessToken;

  @override
  String? get refreshToken => _refreshToken;

  @override
  Future<void> cacheUserData(UserModel user) async {
    await sharedPreferences.setString(_userDataKey, json.encode(user.toJson()));
    await sharedPreferences.setString(_accessTokenKey, user.accessToken);
    await sharedPreferences.setString(_refreshTokenKey, user.refreshToken);

    _userModel = user;
    _accessToken = user.accessToken;
    _refreshToken = user.refreshToken;
  }

  @override
  Future<UserModel> getCachedUserData() async {
    if (_userModel != null) return _userModel!;

    final userData = sharedPreferences.getString(_userDataKey);
    if (userData != null) {
      _userModel = UserModel.fromJson(json.decode(userData));
      return _userModel!;
    } else {
      throw CacheException('No cached session found');
    }
  }

  @override
  Future<void> updateTokens(String newAccessToken, String newRefreshToken) async {
    await sharedPreferences.setString(_accessTokenKey, newAccessToken);
    await sharedPreferences.setString(_refreshTokenKey, newRefreshToken);

    _accessToken = newAccessToken;
    _refreshToken = newRefreshToken;
  }

  @override
  Future<void> clearCachedUserData() async {
    await sharedPreferences.remove(_userDataKey);
    await sharedPreferences.remove(_accessTokenKey);
    await sharedPreferences.remove(_refreshTokenKey);

    _userModel = null;
    _accessToken = null;
    _refreshToken = null;
  }
}