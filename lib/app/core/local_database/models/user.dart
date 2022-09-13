import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late final String id;
  @HiveField(1)
  late final String firstName;
  @HiveField(2)
  late final String lastName;
  @HiveField(3)
  late final String email;
  @HiveField(4)
  late final String password;
  @HiveField(5)
  late final String username;
  @HiveField(6)
  late final String phoneNumber;
  @HiveField(7)
  late final String driverLicense;
  @HiveField(8)
  late final String profileImg;
  @HiveField(9)
  late final String token;
}
