import 'dart:convert';
import 'package:carpooling_beta/app/Home/data/models/ride_model.dart';
import 'package:carpooling_beta/app/Home/data/models/checking_model.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class BaseRideRemoteDataSource {
  Future<List<RideModel>> getMyRides(String userId);
  Future<List<CheckingModel>> getMyChecking(String userId);
}

class RideRemoteDataSource extends BaseRideRemoteDataSource {
  @override
  Future<List<RideModel>> getMyRides(String userId) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.getRidesPath),
        headers: AppConstants.headers,
        body: jsonEncode({
          "fromPlace": null,
          "toPlace": null,
          "departureDate": null,
          "requestedSeats": 0,
          "driverId": userId,
        }),
      );

      return List<RideModel>.from(
          (jsonDecode(AppConstants.httpResponseHandler(response)) as List)
              .map((e) => RideModel.fromJson(e)));
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
  Future<List<CheckingModel>> getMyChecking(String userId) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.getCheckingsPath),
        headers: AppConstants.headers,
        body: jsonEncode({
          "rideId": null,
          "passagerId": userId,
        }),
      );

      return List<CheckingModel>.from(
          (jsonDecode(AppConstants.httpResponseHandler(response)) as List)
              .map((e) => CheckingModel.fromJson(e)));
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
