import 'dart:convert';

import 'package:fake_api_bkash/app/controller/auth_controller.dart';
import 'package:fake_api_bkash/core/models/network_response.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';


class NetworkCaller {
  final String _defaultErrorMsg = "Something went wrong";
  final String _unauthorizeMsg  = "Un-authorized token";

  Future<Map<String, String>> _getHeaders(bool auth) async{
    Map<String,String> headers = {'Content-Type' : 'application/json'};

    if(auth){
      final String token = Get.find<AuthController>().accessToken ?? '';
       headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<NetworkResponse> getRequest(String url,{
    bool authReq = false,
  }) async{
    try{
      final headers = await _getHeaders(authReq);
      final uri = Uri.parse(url);
      Response response = await get(uri, headers: headers);
      if(response.statusCode == 200){
        final decode = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode,body: decode);
      }
      else if(response.statusCode == 401){
        return NetworkResponse(isSuccess: false, statusCode:response.statusCode,errorMsg: _unauthorizeMsg );
      }else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMsg: decodedJson['data'] ?? _defaultErrorMsg,
        );
      }
    }catch (e){
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMsg: e.toString(),
      );

    }
  }
}