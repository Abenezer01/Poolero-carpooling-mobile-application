import 'package:carpooling_beta/app/Home/domain/entities/checking.dart';
import 'package:carpooling_beta/app/Home/data/models/ride_model.dart';
import 'package:carpooling_beta/app/Home/data/models/passager_model.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:flutter/foundation.dart';

class CheckingModel extends Checking {
  CheckingModel({
    required super.id,
    required super.passager,
    required super.ride,
    required super.requestedSeats,
  });

  factory CheckingModel.fromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey('id')) {
        throw DataError.missingParameters();
      }
      print('CheckingModel:');
      print(json);
      return CheckingModel(
        id: json['id'],
        passager: PassagerModel.fromJson(json['passager']),
        ride: RideModel.fromJson(json['ride']),
        requestedSeats: json['requestedSeats'],
      );
    } on DataError catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      print('PlaceModel');
      debugPrint(e.toString());
      throw DataError.failedToConvert();
    }
  }
}
