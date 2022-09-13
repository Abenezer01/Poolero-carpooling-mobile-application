import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final User user;
  final List<Car>? carsList;

  const Profile({
    required this.user,
    this.carsList,
  });

  @override
  List<Object?> get props => [
        user,
        carsList,
      ];
}
