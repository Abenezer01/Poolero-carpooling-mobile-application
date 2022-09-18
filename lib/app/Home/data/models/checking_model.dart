import 'package:carpooling_beta/app/Home/domain/entities/Passager.dart';
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
      final passager = PassagerModel.fromJson(json['passager']);
      return CheckingModel(
        id: json['id'],
        passager: Passager(
          id: passager.id,
          firstName: passager.firstName,
          lastName: passager.lastName,
          userName: passager.userName,
          email: passager.email,
        ),
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
