import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/local_database/operations/user_operations.dart';

abstract class BaseProfileLocalDataSource {
  Future<User> getProfile();
}

class ProfileLocalDataSource extends BaseProfileLocalDataSource {
  final BaseLocalDatabaseOperations baseLocalDatabaseOperations;
  ProfileLocalDataSource(this.baseLocalDatabaseOperations);
  @override
  Future<User> getProfile() async {
    try {
      final user = await baseLocalDatabaseOperations.get();
      return user;
    } catch (e) {
      print(e.toString());
      throw DataError.failedToGet();
    }
  }
}
