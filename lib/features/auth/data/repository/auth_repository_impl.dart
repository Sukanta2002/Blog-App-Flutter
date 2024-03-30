import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDatasource authSupabaseDatasource;

  AuthRepositoryImpl(this.authSupabaseDatasource);
  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final user = await authSupabaseDatasource.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );
      return right(user);
    } on ServerExecption catch (e) {
      return left(Failure(e.message));
    }
  }
}
