import "dart:convert";

import "package:firebase_code/api/constants.dart";
import "package:firebase_code/api/service/basic/response_data.dart";
import "package:http/http.dart" as http;
import "package:logger/logger.dart";

class NetworkCaller {
  final Logger _logger = Logger();

  Map<String, String> _getHeaders(bool authReq) {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    if (authReq) {
      headers['Authorization'] = 'Bearer ${Constants.token}';
    }
    return headers;
  }

  Future<NetworkResponse> getRequest({
    required String url,

    authReq = false,
  }) async {
    try {
      final uri = Uri.parse(url);
      final headers = _getHeaders(authReq);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodeJson,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: "Unauthorized request, please check your credentials.",
        );
      } else {
        final decodeJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage:
              decodeJson['data'] ??
              "Something went wrong, please try again later.",
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? queryParams,
    authReq = false,
  }) async {
    try {
      final uri = Uri.parse(url);
      final headers = _getHeaders(authReq);
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(queryParams),
      );
      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodeJson,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: "Unauthorized request, please check your credentials.",
        );
      } else {
        final decodeJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage:
              decodeJson['data'] ??
              "Something went wrong, please try again later.",
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(
    String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  ) {
    _logger.i(
      '================== REQUEST ========================\n'
      'URL: $url\n'
      'HEADERS: $headers\n'
      'BODY: $body\n'
      '=============================================',
    );
  }

  void _logResponse(String url, http.Response response) {
    _logger.i(
      '=================== RESPONSE =======================\n'
      'URL: $url\n'
      'STATUS CODE: ${response.statusCode}\n'
      'BODY: ${response.body}\n'
      '=============================================',
    );
  }
}
