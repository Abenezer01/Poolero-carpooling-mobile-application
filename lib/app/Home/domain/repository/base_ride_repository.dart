import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Checking.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

abstract class BaseRideRepository {
  Future<Either<DomainError, List<Ride>>> getMyRidesRepo(String userId);
  Future<Either<DomainError, List<Checking>>> getMyCheckingsRepo(String userId);
}
