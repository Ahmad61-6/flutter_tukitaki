import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:taghyeer_technology/core/network/urls/api_urls.dart';

import '../../features/auth/data/data_sources/auth_local_data_source.dart';

part 'network_response.dart';

class NetworkClient {
  final Logger _logger = Logger();
  final String _defaultErrorMessage = 'Something went wrong';

  final VoidCallback onUnAuthorize;

  bool _isRefreshing = false;

  NetworkClient({
    required this.onUnAuthorize,
  });

  Map<String, String> _getHeaders() {
    final token = Get.find<AuthLocalDataSource>().accessToken;
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<NetworkResponse> getRequest(String url, {bool isRetry = false}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, headers: _getHeaders());

      final http.Response response = await http.get(uri, headers: _getHeaders());
      _logResponse(response);

      return await _handleResponse(response, () => getRequest(url, isRetry: true), isRetry);
    } on Exception catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> postRequest(String url, {Map<String, dynamic>? body, bool isRetry = false}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, headers: _getHeaders(), body: body);

      final http.Response response = await http.post(
        uri,
        headers: _getHeaders(),
        body: jsonEncode(body),
      );
      _logResponse(response);

      return await _handleResponse(response, () => postRequest(url, body: body, isRetry: true), isRetry);
    } on Exception catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }


  Future<NetworkResponse> _handleResponse(
      http.Response response,
      Future<NetworkResponse> Function() retryCallback,
      bool isRetry,
      ) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return NetworkResponse(
        isSuccess: true,
        statusCode: response.statusCode,
        responseData: jsonDecode(response.body),
      );
    }

    else if (response.statusCode == 401 && !isRetry) {
      _logger.w("401 Unauthorized caught. Attempting to refresh token...");

      final bool refreshSuccess = await _refreshToken();

      if (refreshSuccess) {
        _logger.i("Token refreshed successfully. Retrying original request...");
        return await retryCallback();
      } else {
        _logger.e("Refresh token failed or expired. Forcing logout.");
        onUnAuthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: 401,
          errorMessage: 'Session expired. Please log in again.',
        );
      }
    }

    else {
      final responseBody = jsonDecode(response.body);
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: responseBody['message'] ?? responseBody['msg'] ?? _defaultErrorMessage,
      );
    }
  }


  Future<bool> _refreshToken() async {
    if (_isRefreshing) return false;
    _isRefreshing = true;

    try {
      final localDataSource = Get.find<AuthLocalDataSource>();
      final String? refreshToken = localDataSource.refreshToken;

      if (refreshToken == null) return false;

      final response = await http.post(
        Uri.parse('${ApiUrls.baseUrl}/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'refreshToken': refreshToken,
          'expiresInMins': 30,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await localDataSource.updateTokens(data['accessToken'], data['refreshToken']);
        return true;
      }
      return false;
    } catch (e) {
      _logger.e("Error during token refresh: $e");
      return false;
    } finally {
      _isRefreshing = false;
    }
  }


  void _logRequest(String url, {Map<String, String>? headers, Map<String, dynamic>? body}) {
    _logger.i('URL -> $url\nHEADERS -> $headers\nBODY -> $body');
  }

  void _logResponse(http.Response response) {
    _logger.i('URL -> ${response.request?.url}\nSTATUS CODE -> ${response.statusCode}\nBODY -> ${response.body}');
  }
}