import 'package:equatable/equatable.dart';

class Passager extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final int requestedSeats;

  Passager({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.requestedSeats,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        userName,
        email,
        requestedSeats,
      ];
}
