part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SignInUser extends UserEvent {
  final SignInParams params;
  SignInUser(this.params);
}

class SignUpUser extends UserEvent {}

class SignOutUser extends UserEvent {}

class CheckUser extends UserEvent {}
