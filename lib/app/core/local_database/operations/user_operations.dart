import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:carpooling_beta/app/core/error_handling/data_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart'
    as local;
import 'package:hive/hive.dart';

abstract class BaseLocalDatabaseOperations<T, P> {
  Future<int> store(P data);
  Future<T?> get();
  Future<int> delete();
  Future<List<Message>> updateConversations(Message message);
  Future<List<Car>?> updateCarList(List<Car> cars);
}

class UserLocalDataBaseOperations
    extends BaseLocalDatabaseOperations<local.User, User> {
  @override
  Future<List<Message>> updateConversations(Message message) async {
    try {
      var box = await get();
      box!.conversations.add(message);

      box.save();

      return box.conversations;
    } catch (_) {
      throw DataError.failedToStore();
    }
  }

  @override
  Future<List<Car>?> updateCarList(List<Car> cars) async {
    // try {
    var box = Hive.box<local.User>('user');
    local.User? user = box.get(box.keys.last);
    final carsList = List<Car>.from(cars.map((e) => Car(
        id: e.id,
        plaque: e.plaque,
        category: e.category,
        color: e.color,
        model: e.model,
        mark: e.mark,
        modelYear: e.modelYear,
        userId: e.userId)));

    box.putAt(0, user!);
    user = box.get(box.keys.last);
    return user!.cars;
    // } catch (_) {
    //   throw DataError.failedToStore();
    // }
  }

  @override
  Future<int> store(User user) async {
    try {
      var box = await Hive.openBox<local.User>('user');
      box.deleteAll(box.keys);
      local.User localUserData = local.User()
        ..id = user.id ?? ''
        ..firstName = user.firstName
        ..lastName = user.lastName
        ..username = user.username
        ..email = user.email
        ..password = user.password ?? ''
        ..phoneNumber = user.phoneNumber ?? ''
        ..driverLicense = user.driverLicense ?? ''
        ..profileImg = user.profileImg ?? ''
        ..token = user.token ?? ''
        ..cars = []
        ..conversations = [];

      int id = await box.add(localUserData);
      if (id <= 0 || id.isNaN) throw DataError.failedToStore();
      return id;
    } catch (_) {
      throw DataError.failedToStore();
    }
  }

  @override
  Future<local.User?> get() async {
    try {
      var box = Hive.box<local.User>('user');
      final user = box.get(box.keys.last);
      return user;
    } catch (_) {
      throw DataError.failedToGet();
    }
  }

  @override
  Future<int> delete() async {
    try {
      var box = Hive.box('user');
      return box.clear();
    } catch (_) {
      throw DataError.failedToLogout();
    }
  }
}
