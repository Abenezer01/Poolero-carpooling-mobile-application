import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:equatable/equatable.dart';

class Car extends Equatable {
  String id;
  final CarProperty category;
  final CarProperty color;
  final CarProperty model;
  final CarProperty mark;
  String modelYear;
  final String userId;
  final String image;

  Car({
    required this.id,
    required this.category,
    required this.color,
    required this.model,
    required this.mark,
    required this.modelYear,
    required this.userId,
    this.image = 'assets/Body Type.png',
  });

  set setId(String id) {
    this.id = id;
  }
  set setModelYear(String year) {
    this.modelYear = year;
  }

  @override
  List<Object?> get props => [
        id,
        category,
        color,
        model,
        mark,
        modelYear,
        userId,
      ];
}
