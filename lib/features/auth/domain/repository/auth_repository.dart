import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  });

  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
