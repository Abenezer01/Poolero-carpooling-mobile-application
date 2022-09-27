
import 'package:carpooling_beta/app/Home/domain/entities/Checking.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

class CheckingsUseCase {
  final BaseRideRepository baseRideRepository;

  CheckingsUseCase(this.baseRideRepository);

  Future<Either<DomainError, List<Checking>>> call(String userId) async {
    // print('CheckingsUseCase');
    return await baseRideRepository.getMyCheckingsRepo(userId);
  }
}
