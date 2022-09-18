import 'package:carpooling_beta/app/Home/data/models/checking_model.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Passager.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Place.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Checking.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

abstract class BaseRideRepository {
  Future<Either<DomainError, List<Ride>>> geRidesRepo(String? fromPlace,String? toPlace,String? date,int requestedSeats,String? driverId);
  Future<Either<DomainError, List<Checking>>> getMyCheckingsRepo(String userId);
  Future<Either<DomainError, Ride>> addRideRepo(Ride ride);
  Future<Either<DomainError, bool>> cancelCheckingRepo(String rideId);
  Future<Either<DomainError, Checking>> addCheckingsRepo(
      Ride ride, int requestedSeats, Passager passager);

  Future<Either<DomainError, List<Ride>>> findRideRepo(
    String? fromPlace,
    String? toPlace,
    String? departureDate,
    int? requestedSeats,
    String? driverId,
  );
}
