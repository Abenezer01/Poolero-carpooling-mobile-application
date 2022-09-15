import 'dart:convert';
import 'package:carpooling_beta/app/Home/data/models/ride_model.dart';
import 'package:carpooling_beta/app/Home/data/models/checking_model.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Place.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class BaseRideRemoteDataSource {
  Future<List<RideModel>> getMyRides(String userId);
  Future<List<CheckingModel>> getMyChecking(String userId);
  Future<Ride> addRide(Ride ride);
  Future<List<RideModel>> findRides(String? fromPlace, String? toPlace,
      String? departureDate, int? requestedSeats, String? driverId);
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

  @override
  Future<Ride> addRide(Ride ride) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.addRidePath),
        headers: AppConstants.headers,
        body: jsonEncode({
          "departureDate": ride.departureDate,
          "endTime": ride.endTime,
          "totalCost": ride.totalCost,
          "totalDistance": ride.totalDistance,
          "meetPoint": ride.meetPoint,
          "numFreeSpots": ride.numFreeSpots,
          "availableSeats": ride.numFreeSpots,
          "allowPauses": ride.allowPauses,
          "allowBigBags": ride.allowBigBags,
          "allowSmoking": ride.allowSmoking,
          "fromPlace": {
            "city": ride.fromPlace.city,
            "adresse": ride.fromPlace.adresse,
            "latitude": ride.fromPlace.latitude,
            "longitude": ride.fromPlace.longitude,
          },
          "toPlace": {
            "city": ride.toPlace.city,
            "adresse": ride.toPlace.adresse,
            "latitude": ride.toPlace.latitude,
            "longitude": ride.toPlace.longitude,
          },
          "carId": ride.car,
          "driverId": ride.driver,
          "status": ride.status,
        }),
      );
      print('RideRemoteDataSource');
      print(response.statusCode);
      print(ride);
      print(AppConstants.addRidePath);
      AppConstants.httpResponseHandler(response);

      return ride;
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
  Future<List<RideModel>> findRides(String? fromPlace, String? toPlace,
      String? departureDate, int? requestedSeats, String? driverId) async {
    try {
      print("RideRemoteDataSource");
      print(
          'fromPlace: $fromPlace - toPlace: $toPlace - departureDate: $departureDate - requestedSeats: $requestedSeats - driverId: $driverId');
      http.Response response = await http.post(
        Uri.parse(AppConstants.getRidesPath),
        headers: AppConstants.headers,
        body: jsonEncode({
          "fromPlace": fromPlace,
          "toPlace": toPlace,
          "departureDate": departureDate,
          "requestedSeats": requestedSeats,
          "driverId": driverId,
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
}
