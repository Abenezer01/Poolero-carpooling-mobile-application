import 'package:carpooling_beta/app/Home/data/datasource/ride_remote_datasource.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Checking.dart';
import 'package:dartz/dartz.dart';

class RideRepository extends BaseRideRepository {
  final BaseRideRemoteDataSource baseRideRemoteDataSource;

  RideRepository(this.baseRideRemoteDataSource);

  @override
  Future<Either<DomainError, List<Ride>>> getMyRidesRepo(String userId) async {
    try {
      print('RideRepository');
      final myRides = await baseRideRemoteDataSource.getMyRides(userId);

      return Right(myRides);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, List<Checking>>> getMyCheckingsRepo(
      String userId) async {
    try {
      print('RideRepository');
      final myCheckings = await baseRideRemoteDataSource.getMyChecking(userId);

      return Right(myCheckings);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }
}
