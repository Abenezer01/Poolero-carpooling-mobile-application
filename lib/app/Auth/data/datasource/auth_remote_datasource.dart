import 'dart:convert';
import 'package:carpooling_beta/app/Auth/data/models/user_model.dart';
import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class BaseAuthRemoteDataSource {
  Future<UserModel> loginRequest(String email, String password);
  Future<String> registerRequest(User user);
  Future<UserModel> updateUserRequest(User user);
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<UserModel> loginRequest(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.loginPath),
        headers: AppConstants.headers,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print('response');
      print(response.statusCode);

      return UserModel.fromJson(
          jsonDecode(AppConstants.httpResponseHandler(response)));
    } on DioError catch (error) {
      debugPrint(error.toString());
      if (error.type == DioErrorType.connectTimeout) {
        throw HttpError.timeOut();
      } else {
        throw HttpError.serverError();
      }
    } on HttpError catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<String> registerRequest(User user) async {
    http.Response response = await http.post(
      Uri.parse(AppConstants.registerPath),
      headers: AppConstants.headers,
      body: jsonEncode({
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email,
        "userName": user.username,
        "password": user.password,
        "driverLicense": user.driverLicense,
        "phoneNumber": user.phoneNumber,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)['userId'].toString();
    }
    throw AppConstants.httpResponseHandler(response);
  }

  @override
  Future<UserModel> updateUserRequest(User user) async {
    http.Response response = await http.post(
      Uri.parse(AppConstants.updateUserPath),
      headers: AppConstants.headers,
      body: jsonEncode({
        "id": user.id,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email,
        "userName": user.username,
        "password": user.password,
        "driverLicense": user.driverLicense,
        "phoneNumber": user.phoneNumber,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    throw AppConstants.httpResponseHandler(response);
  }
}
