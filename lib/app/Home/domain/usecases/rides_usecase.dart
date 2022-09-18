import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/Auth/domain/repository/base_auth_repository.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Checking.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

class GetRidesUseCase {
  final BaseRideRepository baseRideRepository;

  GetRidesUseCase(this.baseRideRepository);

  Future<Either<DomainError, List<Ride>>> call(String? fromPlace,String? toPlace,String? date,int requestedSeats,String? driverId) async {
    print('RidesUseCase');
    return await baseRideRepository.geRidesRepo(fromPlace,toPlace,date,requestedSeats,driverId);
  }

}
