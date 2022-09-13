import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAuthRepository {
  Future<Either<DomainError, User>> loginRepo(String email, String password);
  Future<Either<DomainError, String>> registerRepo(User user);
  Future<Either<DomainError, User>> updateAccountRepo(User user);
  // Future<Either<DomainError, User>> userLocalStoreRepo(User user);
}
