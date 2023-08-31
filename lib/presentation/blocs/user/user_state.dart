part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLogged extends UserState {}

class UserLoggedFail extends UserState {}

class UserLoggedOut extends UserState {}
