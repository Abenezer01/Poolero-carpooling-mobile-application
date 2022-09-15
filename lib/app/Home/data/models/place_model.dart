import 'package:carpooling_beta/app/Home/domain/entities/Place.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:flutter/foundation.dart';

class PlaceModel extends Place {
  PlaceModel({
    required super.id,
    required super.city,
    required super.adresse,
    required super.latitude,
    required super.longitude,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    try {
      print('PlaceModel:');
      print(json);
      if (!json.containsKey('id')) {
        throw DataError.missingParameters();
      }
      return PlaceModel(
        id: json['id'],
        city: json['city'],
        adresse: json['adresse'],
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
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
