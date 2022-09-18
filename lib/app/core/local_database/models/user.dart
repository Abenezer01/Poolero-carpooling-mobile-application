import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late final String id;
  @HiveField(1)
  late String firstName;
  @HiveField(2)
  late String lastName;
  @HiveField(3)
  late String email;
  @HiveField(4)
  late String password;
  @HiveField(5)
  late String username;
  @HiveField(6)
  late String phoneNumber;
  @HiveField(7)
  late String driverLicense;
  @HiveField(8)
  late String profileImg;
  @HiveField(9)
  late String token;
  @HiveField(10)
  late List<Car>? cars;
  @HiveField(11)
  late List<Message> conversations;
}
