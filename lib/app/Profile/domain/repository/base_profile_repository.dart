
import 'package:carpooling_beta/app/Profile/domain/entities/Profile.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

abstract class BaseProfileRepository {
  Future<Either<DomainError, Profile>> profileRepo();
}
