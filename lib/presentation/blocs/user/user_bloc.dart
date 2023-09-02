import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/user/user.dart';
import '../../../domain/usecases/user/sign_in_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInUseCase _signInUseCase;
  UserBloc(this._signInUseCase) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
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
      print(e);
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }
}
