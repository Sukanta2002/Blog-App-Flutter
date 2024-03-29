import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/usecase/signup_usercase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  AuthBloc({required SignUpUsecase signUpUsecase})
      : _signUpUsecase = signUpUsecase,
        super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      final res = await _signUpUsecase(
        UserSignupParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      res.fold(
        (l) => emit(AuthFailure(l)),
        (r) => emit(
          AuthSucess(r),
        ),
      );
    });
  }
}
