import 'dart:convert';
import 'package:carpooling_beta/app/Profile/data/models/car_property_model.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:carpooling_beta/app/core/local_database/operations/user_operations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class BaseCarRemoteDataSource {
  Future<List<CarProperty>> getProperty(String propertyPath);
  Future<Car> addCar(Car car);
  Future<Car> updateCar(Car car);
  Future<bool> deleteCar(String carId);
}

class CarRemoteDataSource extends BaseCarRemoteDataSource {
  @override
  Future<List<CarProperty>> getProperty(String propertyPath) async {
    try {
      http.Response response = await http.get(
        Uri.parse(propertyPath),
        headers: AppConstants.headers,
      );

      return List<CarProperty>.from(
          (jsonDecode(AppConstants.httpResponseHandler(response)) as List)
              .map((e) => CarPropertyModel.fromJson(e)));
      ;
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
  Future<Car> addCar(Car car) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.addUpdateCarPath),
        headers: AppConstants.headers,
        body: jsonEncode({
          "categoryId": car.category.id,
          "colorId": car.color.id,
          "modelId": car.model.id,
          "userId": car.userId,
          "modelYear": car.modelYear,
        }),
      );

      final carId = AppConstants.httpResponseHandler(response);
      car.setId = carId;

      // Save to local DB
      final user = await UserLocalDataBaseOperations().get();
      user!.cars!.add(car);
      user.save();

      return car;
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
  Future<Car> updateCar(Car car) async {
    try {
      http.Response response = await http.put(
        Uri.parse(AppConstants.addUpdateCarPath),
        headers: AppConstants.headers,
        body: jsonEncode({
          "id": car.id,
          "categoryId": car.category.id,
          "colorId": car.color.id,
          "modelId": car.model.id,
          "userId": car.userId,
          "modelYear": car.modelYear,
        }),
      );

      AppConstants.httpResponseHandler(response);

      // Update on local DB
      final user = await UserLocalDataBaseOperations().get();
      user!.cars!.map((element) {
        if (element.id == car.id) {
          element = car;
        }
      });
      user.save();

      return car;
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
  Future<bool> deleteCar(String carId) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(AppConstants.deleteCarPath(carId)),
        headers: AppConstants.headers,
      );

      AppConstants.httpResponseHandler(response);

      // Delete from local DB
      final user = await UserLocalDataBaseOperations().get();
      user!.cars!.removeWhere((element) => element.id == carId);
      user.save();

      return true;
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
