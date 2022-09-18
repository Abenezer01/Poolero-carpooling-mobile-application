import 'package:carpooling_beta/app/Home/data/models/place_model.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:flutter/foundation.dart';

class RideModel extends Ride {
  RideModel({
    required super.id,
    required super.departureDate,
    required super.endTime,
    required super.totalCost,
    required super.totalDistance,
    super.meetPoint,
    required super.numFreeSpots,
    required super.availableSeats,
    super.allowPauses,
    super.allowBigBags,
    super.allowSmoking,
    required super.fromPlace,
    required super.toPlace,
    required super.car,
    required super.driver,
    super.passagers,
    required super.status,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey('id')) {
        throw DataError.missingParameters();
      }
      return RideModel(
        id: json['id'],
        departureDate: json['departureDate'],
        endTime: json['endTime'],
        totalCost: double.parse(json['totalCost'].toString()),
        totalDistance: double.parse(json['totalDistance'].toString()),
        meetPoint: json['meetPoint'],
        numFreeSpots: json['numFreeSpots'],
        availableSeats: json['availableSeats'],
        allowPauses: json['allowPauses'] == 1 ? true : false,
        allowBigBags: json['allowBigBags'] == 1 ? true : false,
        allowSmoking: json['allowSmoking'] == 1 ? true : false,
        fromPlace: PlaceModel(
          id: json['fromPlace']['id'],
          adresse: json['fromPlace']['adresse'],
          city: json['fromPlace']['city'],
          latitude: json['fromPlace']['latitude'] as double,
          longitude: json['fromPlace']['longitude'] as double,
        ),
        toPlace: PlaceModel(
          id: json['toPlace']['id'],
          adresse: json['toPlace']['adresse'],
          city: json['toPlace']['city'],
          latitude: json['toPlace']['latitude'] as double,
          longitude: json['toPlace']['longitude'] as double,
        ),
        car: '',
        driver: json['driver']['id'],
        passagers: [],
        status: json['status'],
      );
    } on DataError catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      print('RideModel');
      debugPrint(e.toString());
      throw DataError.failedToConvert();
    }
  }
}
