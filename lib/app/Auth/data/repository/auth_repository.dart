import 'package:carpooling_beta/app/Auth/data/datasource/auth_local_datasource.dart';
import 'package:carpooling_beta/app/Auth/data/datasource/auth_remote_datasource.dart';
import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/Auth/domain/repository/base_auth_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:dartz/dartz.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;
  final BaseAuthLocalDataSource baseAuthLocalDataSource;

  AuthRepository(this.baseAuthRemoteDataSource, this.baseAuthLocalDataSource);

  @override
  Future<Either<DomainError, User>> loginRepo(
      String email, String password) async {
    try {
      final user = await baseAuthRemoteDataSource.loginRequest(email, password);
      await baseAuthLocalDataSource.storeUser(user);
      await baseAuthLocalDataSource.getUser();
      return Right(user);
    } on HttpError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, String>> registerRepo(User user) async {
    try {
      final userId = await baseAuthRemoteDataSource.registerRequest(user);
      return Right(userId);
    } on HttpError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, User>> updateAccountRepo(User user) async {
    try {
      final updatedUser =
          await baseAuthRemoteDataSource.updateUserRequest(user);
      return Right(updatedUser);
    } on DomainError catch (e) {
      return Left(e);
    }
  }

  // @override
  // Future<Either<DomainError, User>> userLocalStoreRepo(User user) async {
  //   try {
  //     final storedUser = await baseAuthLocalDataSource.storeUser(user);
  //     return Right(storedUser);
  //   } on DataError catch (e) {
  //     return Left(e);
  //   } on DomainError catch (e) {
  //     return Left(e);
  //   }
  // }
}
