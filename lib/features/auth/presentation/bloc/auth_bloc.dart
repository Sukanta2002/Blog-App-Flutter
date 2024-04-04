import 'package:blog_app/core/common/cubits/user_cubit/user_cubit.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user_entity.dart';
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
  final UserCubit _userCubit;
  AuthBloc({
    required LoginUsecase loginUsecase,
    required SignUpUsecase signUpUsecase,
    required GetCurrentUserUsecase currentUserUsecase,
    required UserCubit userCubit,
  })  : _signUpUsecase = signUpUsecase,
        _loginUsecase = loginUsecase,
        _currentUserUsecase = currentUserUsecase,
        _userCubit = userCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignup>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsLoggedin>(_onAuthIsLoggedin);
  }

  void _onAuthIsLoggedin(AuthIsLoggedin event, Emitter<AuthState> emit) async {
    final res = await _currentUserUsecase(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l)),
      (r) {
        if (r != null) {
          _emitAuthSucess(r, emit);
        }
      },
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _loginUsecase(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(l)),
      (r) => _emitAuthSucess(r, emit),
    );
  }

  void _onAuthSignUp(AuthSignup event, Emitter<AuthState> emit) async {
    final res = await _signUpUsecase(
      UserSignupParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(l)),
      (r) => _emitAuthSucess(r, emit),
    );
  }

  void _emitAuthSucess(UserEntity user, Emitter emit) {
    _userCubit.isUserPresent(user);
    emit(AuthSucess(user));
  }
}
