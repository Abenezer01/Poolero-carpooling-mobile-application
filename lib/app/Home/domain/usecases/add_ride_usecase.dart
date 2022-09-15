import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

class AddRideUseCase {
  final BaseRideRepository baseRideRepository;

  AddRideUseCase(this.baseRideRepository);

  Future<Either<DomainError, Ride>> call(Ride ride) async {
    print('AddRideUseCase');
    return await baseRideRepository.addRideRepo(ride);
  }

}
