import 'package:carpooling_beta/app/Home/domain/entities/Place.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

class FindRideUseCase {
  final BaseRideRepository baseRideRepository;

  FindRideUseCase(this.baseRideRepository);

  Future<Either<DomainError, List<Ride>>> call(Place fromPlace, Place toPlace,
      String departureDate, int requestedSeats, String driverId) async {
    print('FindRideUseCase');
    return await baseRideRepository.findRideRepo(
        fromPlace, toPlace, departureDate, requestedSeats, driverId);
  }
}
