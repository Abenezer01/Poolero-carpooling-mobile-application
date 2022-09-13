import 'dart:convert';
import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/data/models/car_model.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class BaseProfileRemoteDataSource {
  Future<List<Car>> getCars(String userId);
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

      return List<CarModel>.from(
          (jsonDecode(AppConstants.httpResponseHandler(response)) as List)
              .map((e) => CarModel.fromJson(e)));
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
