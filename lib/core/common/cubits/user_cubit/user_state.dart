part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserPresent extends UserState {
  final UserEntity? user;

  UserPresent({required this.user});
}
