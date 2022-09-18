import 'package:equatable/equatable.dart';

class Mark extends Equatable {
  String id;
  String name;

  Mark({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
