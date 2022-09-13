import 'package:carpooling_beta/app/Profile/domain/entities/Profile.dart';
import 'package:carpooling_beta/app/Profile/domain/repository/base_profile_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class ProfileUseCase {
  final BaseProfileRepository baseProfileRepository;

  ProfileUseCase(this.baseProfileRepository);

  Future<Either<DomainError, Profile>> call() async {
    try {
      final profile = await baseProfileRepository.profileRepo();

      return profile;
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
