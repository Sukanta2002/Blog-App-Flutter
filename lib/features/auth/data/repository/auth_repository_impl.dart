import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDatasource authSupabaseDatasource;

  AuthRepositoryImpl(this.authSupabaseDatasource);
  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final String userId =
          await authSupabaseDatasource.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );
      return right(userId);
    } on ServerExecption catch (e) {
      return left(Failure(e.message));
    }
  }
}
