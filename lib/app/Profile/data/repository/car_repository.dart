import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:carpooling_beta/app/Profile/domain/repository/base_car_repository.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';
import 'package:carpooling_beta/app/Profile/data/datasource/car_remote_datasource.dart';

class CarRepository extends BaseCarRepository {
  final BaseCarRemoteDataSource baseCarRemoteDataSource;

  CarRepository(this.baseCarRemoteDataSource);

  @override
  Future<Either<DomainError, List<CarProperty>>> carCategoriesRepo() async {
    try {
      final categories = await baseCarRemoteDataSource
          .getProperty(AppConstants.getCategoriesPath);
      return Right(categories);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, List<CarProperty>>> carColorsRepo() async {
    try {
      final colors =
          await baseCarRemoteDataSource.getProperty(AppConstants.getColorsPath);

      return Right(colors);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, List<CarProperty>>> carMarksRepo() async {
    try {
      final marks =
          await baseCarRemoteDataSource.getProperty(AppConstants.getMarksPath);

      return Right(marks);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, List<CarProperty>>> carModelsRepo() async {
    try {
      final models =
          await baseCarRemoteDataSource.getProperty(AppConstants.getModelsPath);

      return Right(models);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, Car>> addCarRepo(Car car) async {
    try {
      final newCar = await baseCarRemoteDataSource.addCar(car);

      return Right(newCar);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, Car>> updateCarRepo(Car car) async {
    try {
      final newCar = await baseCarRemoteDataSource.updateCar(car);

      return Right(newCar);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, bool>> deleteCarRepo(String carId) async {
    try {
      final deleted = await baseCarRemoteDataSource.deleteCar(carId);
      return Right(deleted);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }
}
