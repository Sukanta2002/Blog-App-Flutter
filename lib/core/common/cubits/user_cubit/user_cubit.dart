import 'package:blog_app/core/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void isUserPresent(UserEntity? user) {
    if (user != null) {
      return emit(UserPresent(user: user));
    } else {
      return emit(UserInitial());
    }
  }
}
