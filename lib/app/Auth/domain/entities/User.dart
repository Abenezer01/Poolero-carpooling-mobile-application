import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String? password;
  final String username;
  final String phoneNumber;
  final String driverLicense;
  final String profileImg;
  final String? token;

  const User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.driverLicense,
    this.token,
    this.password,
    this.profileImg = 'assets/userImg.png',
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        password,
        username,
        phoneNumber,
        driverLicense,
        profileImg,
        token,
      ];
}
