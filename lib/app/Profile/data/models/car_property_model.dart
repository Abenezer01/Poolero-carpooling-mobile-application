import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:flutter/foundation.dart';

class CarPropertyModel extends CarProperty {
  CarPropertyModel({
    required super.id,
    required super.name,
  });

  factory CarPropertyModel.fromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey('id')) {
        throw DataError.missingParameters();
      }
      return CarPropertyModel(
        id: json['id'],
        name: json['name'],
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
