import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object> get props => [
    id,
    firstName,
    lastName,
    email,
  ];
}