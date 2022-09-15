import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/entities/passager.dart';
import 'package:equatable/equatable.dart';

class Checking extends Equatable {
  final String id;
  final Passager passager;
  final Ride ride;
  final int requestedSeats;

  Checking({
    required this.id,
    required this.passager,
    required this.ride,
    required this.requestedSeats,
  });

  @override
  List<Object?> get props => [
        id,
        passager,
        ride,
        requestedSeats,
      ];
}
