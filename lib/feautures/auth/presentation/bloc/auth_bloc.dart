import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/feautures/auth/domain/usecases/current_user.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_Sign_up.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Use cases are private (_) to encapsulate business logic within the Bloc.
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    // Registering event handlers
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthUserLoggedIn>(_isUserLoggedIn);
    
    // Explicitly triggers the loading state when this event is called
    on<AuthEvent>((event, emit) => emit(AuthLoading())); 
  }

  /// Checks if a user session already exists on app startup.
  void _isUserLoggedIn(AuthUserLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _currentUser(NoParams());
    
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  /// Handles new user registration.
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
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  /// Handles returning user authentication.
  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final resp = await _userLogin(
      User_Login_params(
        email: event.email, 
        password: event.password,
      ),
    );

    resp.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  /// Helper method to update the global app user state and emit success.
  void _emitAuthSuccess(User user, Emitter<AuthState> emitter) {
    _appUserCubit.updateUser(user);
    emitter(AuthSuccess(user));
  }
}













// import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
// import 'package:blog_app/core/usecase/usecase.dart';
// import 'package:blog_app/core/common/entities/user.dart';
// import 'package:blog_app/feautures/auth/domain/usecases/current_user.dart';
// import 'package:blog_app/feautures/auth/domain/usecases/user_Sign_up.dart';
// import 'package:blog_app/feautures/auth/domain/usecases/user_login.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final UserSignUp _userSignUp;
//   final UserLogin _userLogin;
//   final CurrentUser _currentUser;
//   final AppUserCubit _appUserCubit;

//   AuthBloc({
//     required UserSignUp userSignUp,
//     required UserLogin userLogin,
//     required CurrentUser currentUser,
//     required AppUserCubit appUserCubit,
//   }) : _userSignUp = userSignUp,
//        _userLogin = userLogin,
//        _currentUser = currentUser,
//        _appUserCubit = appUserCubit,
//        super(AuthInitial()) {
//     on<AuthSignUp>(_onAuthSignUp);
//     on<AuthLogin>(_onAuthLogin);
//     on<AuthUserLoggedIn>(_isUserLoggedIn);
//   }
//   void _isUserLoggedIn(AuthUserLoggedIn event, Emitter<AuthState> emit) async {
//      emit(AuthLoading());

//     final res = await _currentUser(NoParams());
//     res.fold(
//       (l) => emit(AuthFailure(l.message)),
//       (r) => _emitAuthSuccess(r, emit), //r is user
//     );
//   }

//   Future<void> _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());

//     final resp = await _userSignUp(
//       UserSignUpParams(
//         email: event.email,
//         password: event.password,
//         name: event.name,
//       ),
//     );

//     resp.fold(
//       (failure) => emit(AuthFailure(failure.message)),
//       (r) => _emitAuthSuccess(r, emit),//r is user
//     );
//   }

//   Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());

//     final resp = await _userLogin(
//       User_Login_params(email: event.email, password: event.password),
//     );

//     resp.fold(
//       (failure) => emit(AuthFailure(failure.message)),
//       (r) => _emitAuthSuccess(r, emit), // if succes pass that user r is user
//     );
//   }

//   void _emitAuthSuccess(User user, Emitter<AuthState> emitter) {
//     _appUserCubit.updateUser(user);

//     emitter(AuthSuccess(user));
//   }
// }
// //taking this as private so that this confidential data will not be visible outside so we have made it private
// //this._usersignup not allwoed
// // this part is beign developed after the usecase signup.dart and using that usecase in tthis bloc event state and things

// //user signup screeen connection after the 23;26 ---12 6 26
//  // =========================================================================
//   // AUTH SIGNUP HANDLER
//   // =========================================================================
//   //
//   // Moved signup implementation into a separate private function.
//   // This keeps constructor clean and follows Single Responsibility Principle.
//   //// =========================================================================
//   // AUTH LOGIN HANDLER
//   // =========================================================================




