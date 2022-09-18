import 'package:carpooling_beta/app/Profile/domain/repository/base_profile_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class UpdateProfileUseCase {
  final BaseProfileRepository baseProfileRepository;

  UpdateProfileUseCase(this.baseProfileRepository);

  Future<Either<DomainError, User>> call(
      String id,
      String firstName,
      String lastName,
      String username,
      String email,
      String phoneNumber,
      String driverLicence) async {
    try {
      final newUser = User()
        ..id = id
        ..firstName = firstName
        ..lastName = lastName
        ..username = username
        ..email = email
        ..phoneNumber = phoneNumber
        ..driverLicense = driverLicence;
      final profile = await baseProfileRepository.updateProfileRepo(newUser);

      return profile;
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
