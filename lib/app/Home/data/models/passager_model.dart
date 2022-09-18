import 'package:carpooling_beta/app/Home/domain/entities/Passager.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:flutter/foundation.dart';

class PassagerModel extends Passager {
  PassagerModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.userName,
    required super.email,
  });

  factory PassagerModel.fromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey('id')) {
        throw DataError.missingParameters();
      }
      
      return PassagerModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        userName: json['userName'],
        email: json['email'],
      );
    } on DataError catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      print('PassagerModel');
      debugPrint(e.toString());
      throw DataError.failedToConvert();
    }
  }
}
