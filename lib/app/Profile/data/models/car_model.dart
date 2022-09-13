import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:flutter/foundation.dart';

class CarModel extends Car {
  CarModel({
    required super.id,
    required super.category,
    required super.color,
    required super.model,
    required super.mark,
    required super.modelYear,
    required super.userId,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey('id')) {
        throw DataError.missingParameters();
      }
      return CarModel(
        id: json['id'],
        category: CarProperty(
            id: json['category']['id'], name: json['category']['name']),
        color:
            CarProperty(id: json['color']['id'], name: json['color']['name']),
        model:
            CarProperty(id: json['model']['id'], name: json['model']['name']),
        mark: CarProperty(
            id: json['model']['mark']['id'],
            name: json['model']['mark']['name']),
        modelYear: json['modelYear'],
        userId: json['user']['id'],
      );
    } on DataError catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw DataError.failedToConvert();
    }
  }
}
