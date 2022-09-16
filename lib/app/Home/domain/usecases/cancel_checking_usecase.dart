import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

class CancelChechingUseCase {
  final BaseRideRepository baseRideRepository;

  CancelChechingUseCase(this.baseRideRepository);

  Future<Either<DomainError, bool>> call(String rideId) async {
    print('DeleteRideUseCase');
    return await baseRideRepository.cancelCheckingRepo(rideId);
  }

}
