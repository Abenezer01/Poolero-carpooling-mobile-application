import 'package:equatable/equatable.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Place.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Passager.dart';

enum Status {
  Planned,
  In_Progress,
  Finished,
}

class Ride extends Equatable {
  final String id;
  final String departureDate;
  final String endTime;
  final double totalCost;
  final double totalDistance;
  final String meetPoint;
  final int numFreeSpots;
  final int availableSeats;
  final bool allowPauses;
  final bool allowBigBags;
  final bool allowSmoking;
  final Place fromPlace;
  final Place toPlace;
  final String car;
  final String driver;
  final List<Passager> passagers;
  final int status;

  const Ride({
    required this.id,
    required this.departureDate,
    required this.endTime,
    required this.totalCost,
    required this.totalDistance,
    this.meetPoint = '',
    required this.numFreeSpots,
    required this.availableSeats,
    this.allowPauses = false,
    this.allowBigBags = false,
    this.allowSmoking = false,
    required this.fromPlace,
    required this.toPlace,
    required this.car,
    required this.driver,
    this.passagers = const [],
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        departureDate,
        endTime,
        totalCost,
        totalDistance,
        meetPoint,
        numFreeSpots,
        availableSeats,
        allowPauses,
        allowBigBags,
        allowSmoking,
        fromPlace,
        toPlace,
        car,
        driver,
        passagers,
        status,
      ];
}
