import 'package:carpooling_beta/app/Home/data/datasource/ride_remote_datasource.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Passager.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Place.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Checking.dart';
import 'package:dartz/dartz.dart';

class RideRepository extends BaseRideRepository {
  final BaseRideRemoteDataSource baseRideRemoteDataSource;

  RideRepository(this.baseRideRemoteDataSource);

  @override
  Future<Either<DomainError, List<Ride>>> geRidesRepo(String? fromPlace,String? toPlace,String? date,int requestedSeats,String? driverId) async {
    try {
      // print('RideRepository');
      final myRides = await baseRideRemoteDataSource.getMyRides(fromPlace,toPlace,date,requestedSeats,driverId);

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
      // print('getMyCheckingsRepo');
      final myCheckings = await baseRideRemoteDataSource.getMyChecking(userId);
      final checkings = List<Checking>.from(myCheckings.map((e) => Checking(
            id: e.id,
            passager: Passager(
                id: e.passager.id,
                firstName: e.passager.firstName,
                lastName: e.passager.lastName,
                userName: e.passager.userName,
                email: e.passager.email),
            ride: e.ride,
            requestedSeats: e.requestedSeats,
          )));
      print(checkings);
      return Right(checkings);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, Ride>> addRideRepo(Ride ride) async {
    try {
      // print('RideRepository');
      final newRide = await baseRideRemoteDataSource.addRide(ride);

      return Right(newRide);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, bool>> cancelCheckingRepo(String rideId) async {
    try {
      // print('RideRepository');
      final deleted = await baseRideRemoteDataSource.cancelChecking(rideId);

      return Right(deleted);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, List<Ride>>> findRideRepo(
      String? fromPlace,
      String? toPlace,
      String? departureDate,
      int? requestedSeats,
      String? driverId) async {
    try {
      // print('RideRepository');
      final ridesList = await baseRideRemoteDataSource.findRides(
          fromPlace, toPlace, departureDate, requestedSeats, driverId);

      return Right(ridesList);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, Checking>> addCheckingsRepo(
      Ride ride, int requestedSeats, Passager passager) async {
    try {
      print('addCheckingsRepo');
      final newChecking = await baseRideRemoteDataSource.addChecking(
          ride, requestedSeats, passager);

      return Right(newChecking);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }
}
