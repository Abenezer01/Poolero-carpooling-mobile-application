import 'package:equatable/equatable.dart';

class Color extends Equatable {
  String id;
  String name;

  Color({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
