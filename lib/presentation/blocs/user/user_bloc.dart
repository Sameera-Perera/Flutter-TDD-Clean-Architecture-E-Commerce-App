import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/user/user.dart';
import '../../../domain/usecases/user/get_cached_user_usecase.dart';
import '../../../domain/usecases/user/sign_in_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInUseCase _signInUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;
  UserBloc(this._signInUseCase, this._getCachedUserUseCase)
      : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
    on<CheckUser>(_onCheckUser);
  }

  void _onSignIn(SignInUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signInUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onCheckUser(CheckUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _getCachedUserUseCase(NoParams());
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }
}
