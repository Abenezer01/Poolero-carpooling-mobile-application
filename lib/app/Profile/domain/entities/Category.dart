import 'package:equatable/equatable.dart';

class Category extends Equatable {
  String id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
