part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSucess extends AuthState {
  final UserEntity user;

  AuthSucess(this.user);
}

final class AuthFailure extends AuthState {
  final Failure failure;

  AuthFailure(this.failure);
}
