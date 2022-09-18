import 'package:carpooling_beta/app/Profile/data/datasource/profile_local_datasource.dart';
import 'package:carpooling_beta/app/Profile/data/datasource/profile_remote_datasource.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/Profile.dart';
import 'package:carpooling_beta/app/Profile/domain/repository/base_profile_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:dartz/dartz.dart';

class ProfileRepository extends BaseProfileRepository {
  final BaseProfileLocalDataSource baseProfileLocalDataSource;
  final BaseProfileRemoteDataSource baseProfileRemoteDataSource;

  ProfileRepository(
      this.baseProfileLocalDataSource, this.baseProfileRemoteDataSource);

  @override
  Future<Either<DomainError, Profile>> profileRepo() async {
    try {
      final user = await baseProfileLocalDataSource.getProfile();
      final cars = await baseProfileRemoteDataSource.getCars(user.id);

      return Right(Profile(user: user, carsList: cars));
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, User>> updateProfileRepo(User newUser) async {
    try {
      final user = await baseProfileRemoteDataSource.updateProfile(newUser);

      return Right(user);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }
}
