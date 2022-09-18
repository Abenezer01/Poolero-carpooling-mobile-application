import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:carpooling_beta/app/Profile/domain/repository/base_car_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class CarUseCase {
  final BaseCarRepository baseCarRepository;

  CarUseCase(this.baseCarRepository);

  Future<Either<DomainError, Map<String, dynamic>>> getCarProperties() async {
    try {
      Map<String, List<CarProperty>> properties = {};
      await baseCarRepository
          .carCategoriesRepo()
          .then((value) => value.fold((l) => null, (r) {
                properties['categories'] = r;
              }));

      await baseCarRepository
          .carColorsRepo()
          .then((value) => value.fold((l) => null, (r) {
                properties['colors'] = r;
              }));

      await baseCarRepository
          .carMarksRepo()
          .then((value) => value.fold((l) => null, (r) {
                properties['marks'] = r;
              }));

      await baseCarRepository
          .carModelsRepo()
          .then((value) => value.fold((l) => null, (r) {
                properties['models'] = r;
              }));

      return Right(properties);
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Either<DomainError, Car>> addCar(Car car) async {
    try {
      return baseCarRepository.addCarRepo(car);
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Either<DomainError, Car>> updateCar(Car car) async {
    try {
      return baseCarRepository.updateCarRepo(car);
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Either<DomainError, bool>> deleteCar(String carId) async {
    try {
      return baseCarRepository.deleteCarRepo(carId);
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
