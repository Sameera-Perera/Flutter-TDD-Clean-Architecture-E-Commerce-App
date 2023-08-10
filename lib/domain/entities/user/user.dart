import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [
    id,
    name,
  ];
}