import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/Auth/domain/repository/base_auth_repository.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

class RidesUseCase {
  final BaseRideRepository baseRideRepository;

  RidesUseCase(this.baseRideRepository);

  Future<Either<DomainError, List<Ride>>> call(String userId) async {
    print('RidesUseCase');
    return await baseRideRepository.getMyRidesRepo(userId);
  }
}
