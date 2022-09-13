import 'package:carpooling_beta/app/Auth/data/models/user_model.dart';
import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:carpooling_beta/app/core/local_database/operations/user_operations.dart';

abstract class BaseAuthLocalDataSource {
  Future<int> storeUser(UserModel user);
  Future<User> getUser();
  Future<int> deleteUser();
}

class AuthLocalDataSource extends BaseAuthLocalDataSource {
  final BaseLocalDatabaseOperations baseLocalDatabaseOperations;
  AuthLocalDataSource(this.baseLocalDatabaseOperations);
  @override
  Future<int> storeUser(User user) async {
    try {
      return await baseLocalDatabaseOperations.store(user);
    } catch (_) {
      throw DataError.failedToStore();
    }
  }

  @override
  Future<User> getUser() async {
    try {
      final user = await baseLocalDatabaseOperations.get();
      return User(
        id: user!.id ?? '',
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        password: user.password ?? '',
        username: user.username,
        phoneNumber: user.phoneNumber ?? '',
        driverLicense: user.driverLicense ?? '',
        profileImg: user.profileImg ?? '',
        token: user.token ?? '',
      );
    } catch (_) {
      throw DataError.failedToGet();
    }
  }

  @override
  Future<int> deleteUser() async {
    try {
      return await baseLocalDatabaseOperations.delete();
    } catch (_) {
      throw DataError.failedToLogout();
    }
  }
}
