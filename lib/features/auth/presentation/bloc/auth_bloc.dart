import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/signup_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  final LoginUsecase _loginUsecase;
  final GetCurrentUserUsecase _currentUserUsecase;
  AuthBloc(
      {required LoginUsecase loginUsecase,
      required SignUpUsecase signUpUsecase,
      required GetCurrentUserUsecase currentUserUsecase})
      : _signUpUsecase = signUpUsecase,
        _loginUsecase = loginUsecase,
        _currentUserUsecase = currentUserUsecase,
        super(AuthInitial()) {
    on<AuthSignup>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsLoggedin>(_onAuthIsLoggedin);
  }

  void _onAuthIsLoggedin(AuthIsLoggedin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _currentUserUsecase(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l)),
      (r) {
        if (r != null) {
          print(r.email);
          print(r.id);
          emit(AuthSucess(r));
        }
      },
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _loginUsecase(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(l)),
      (r) => emit(AuthSucess(r)),
    );
  }

  void _onAuthSignUp(AuthSignup event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signUpUsecase(
      UserSignupParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(l)),
      (r) => emit(AuthSucess(r)),
    );
  }
}
