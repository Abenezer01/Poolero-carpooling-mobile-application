import 'dart:convert';
import 'package:carpooling_beta/app/Auth/data/models/user_model.dart';
import 'package:carpooling_beta/app/Profile/data/models/profile_model.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/data/models/car_model.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/Profile.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/local_database/operations/user_operations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class BaseProfileRemoteDataSource {
  Future<List<Car>> getCars(String userId);
  Future<User> updateProfile(User user);
}

class ProfileRemoteDataSource extends BaseProfileRemoteDataSource {
  @override
  Future<List<Car>> getCars(String userId) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.getCarsPath),
        headers: AppConstants.headers,
        body: jsonEncode({
          "userId": userId,
        }),
      );

      final cars = List<CarModel>.from(
          (jsonDecode(AppConstants.httpResponseHandler(response)) as List)
              .map((e) => CarModel.fromJson(e)));

      // final carsList = await UserLocalDataBaseOperations().updateCarList(cars);
      // print('CAR-LIST');
      // print(carsList);
      return cars;
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

  Future<User> updateProfile(User newUser) async {
    try {
      print('USER-ID: ${newUser.id}');
      http.Response response = await http.post(
        Uri.parse(AppConstants.updateUserPath),
        headers: AppConstants.headers,
        body: jsonEncode({
          "id": newUser.id,
          "firstName": newUser.firstName,
          "lastName": newUser.lastName,
          "email": newUser.email,
          "phoneNumber": newUser.phoneNumber,
          "userName": newUser.username,
          "password": 'Password123--',
          "driverLicense": newUser.driverLicense,
        }),
      );

      print(response.statusCode);
      print(response.body);

      final profile = UserModel.fromJson(
          jsonDecode(AppConstants.httpResponseHandler(response)));
      final user = await UserLocalDataBaseOperations().get();
      user!
        // ..id = profile.id!
        ..firstName = profile.firstName
        ..lastName = profile.lastName
        ..username = profile.username
        ..email = profile.email
        ..phoneNumber = profile.phoneNumber
        ..driverLicense = profile.driverLicense;
      user.save();

      return user;
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
}
