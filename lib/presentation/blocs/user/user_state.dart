part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLogged extends UserState {
  final User user;
  UserLogged(this.user);
}

class UserLoggedFail extends UserState {
  final Failure failure;
  UserLoggedFail(this.failure);
}

class UserLoggedOut extends UserState {}
