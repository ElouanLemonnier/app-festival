import 'dart:async';
import 'dart:convert';
import 'package:app_festi/models/login_response_model.dart';
import 'package:app_festi/models/register_request_model.dart';
import 'package:app_festi/models/register_response_model.dart';
import 'package:app_festi/services/shared_service.dart';
import 'package:http/http.dart' as http;
import 'package:app_festi/config.dart';
import 'package:app_festi/models/login_request_model.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if(response.statusCode == 200){
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    }
    else{
      return false;
    }
  }
  static Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(response.body);
  }
}