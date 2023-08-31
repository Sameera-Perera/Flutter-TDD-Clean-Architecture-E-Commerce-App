part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SignInUser extends UserEvent {}

class SignUpUser extends UserEvent {}

class SignOutUser extends UserEvent {}

class CheckUser extends UserEvent {}
