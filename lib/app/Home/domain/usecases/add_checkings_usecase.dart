
import 'package:carpooling_beta/app/Home/domain/entities/Checking.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Passager.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:dartz/dartz.dart';

class AddCheckingUseCase {
  final BaseRideRepository baseRideRepository;

  AddCheckingUseCase(this.baseRideRepository);

  Future<Either<DomainError, Checking>> call(Ride ride,int requestedSeats,Passager passager) async {
    print('AddCheckingUseCase');
    return await baseRideRepository.addCheckingsRepo(ride, requestedSeats,passager);
  }
}
