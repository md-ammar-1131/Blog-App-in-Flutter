import 'package:blog_app/feautures/auth/domain/entities/user.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_Sign_up.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 //taking this as private so that this confidential data will not be visible outside so we have made it private
    //this._usersignup not allwoed
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
   
    : _userSignUp = userSignUp,
      _userLogin = userLogin,
      super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);

  }

  // =========================================================================
  // AUTH SIGNUP HANDLER
  // =========================================================================
  //
  // Moved signup implementation into a separate private function.
  // This keeps constructor clean and follows Single Responsibility Principle.
  //
  Future<void> _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final resp = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    resp.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  // =========================================================================
  // AUTH LOGIN HANDLER
  // =========================================================================

  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final resp = await _userLogin(
      User_Login_params(email: event.email, password: event.password),
    );

    resp.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),// if succes pass that user
      
    );
  }
}

// this part is beign developed after the usecase signup.dart and using that usecase in tthis bloc event state and things

//user signup screeen connection after the 23;26 ---12 6 26
