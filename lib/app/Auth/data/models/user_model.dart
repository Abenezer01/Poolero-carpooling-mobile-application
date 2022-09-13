import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:flutter/foundation.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.username,
    required super.phoneNumber,
    required super.driverLicense,
    required super.token,
    super.profileImg,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey('id')) {
        throw DataError.missingParameters();
      }
      return UserModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        username: json['userName'],
        token: json['token'],
        phoneNumber: json['phoneNumber'] ?? '',
        driverLicense: json['driverLicense'] ?? '',
        profileImg: json['profileImg'] ?? 'assets/userImg.png',
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
