import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

abstract class BaseCarRepository {
  Future<Either<DomainError, List<CarProperty>>> carCategoriesRepo();
  Future<Either<DomainError, List<CarProperty>>> carColorsRepo();
  Future<Either<DomainError, List<CarProperty>>> carMarksRepo();
  Future<Either<DomainError, List<CarProperty>>> carModelsRepo();
  Future<Either<DomainError, Car>> addCarRepo(Car car);
  Future<Either<DomainError, Car>> updateCarRepo(Car car);
  Future<Either<DomainError, bool>> deleteCarRepo(String carId);
}
