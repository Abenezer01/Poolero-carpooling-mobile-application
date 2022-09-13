import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/Auth/domain/repository/base_auth_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class RegisterUseCase {
  final BaseAuthRepository baseAuthRepository;

  RegisterUseCase(this.baseAuthRepository);

  Future<Either<DomainError, String>> call(User user) async {
    try {
      return await baseAuthRepository.registerRepo(user);
    } on HttpError catch (e) {
      debugPrint(e.toString());
      throw e.convertError();
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
