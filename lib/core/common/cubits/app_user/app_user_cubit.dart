// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_app/core/common/entities/user.dart';

import 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());
  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitial());
      //if user logs out se again send them back to initial state as initial state is logged out state
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
