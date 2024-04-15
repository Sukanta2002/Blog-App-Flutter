import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/internet_connection_checker.dart';
import 'package:blog_app/features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/core/entities/user_entity.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDatasource authSupabaseDatasource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(this.authSupabaseDatasource, this.connectionChecker);
  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authSupabaseDatasource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      {required String email,
      required String name,
      required String password}) async {
    return _getUser(
      () async => await authSupabaseDatasource.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity> Function() fun,
  ) async {
    try {
      final isInternetPresent = await connectionChecker.isConnected;
      if (!isInternetPresent) {
        return left(
          Failure("Internet Connection is not present!"),
        );
      }
      final user = await fun();
      return right(user);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExecption catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final isInternetPresent = await connectionChecker.isConnected;
      if (!isInternetPresent) {
        final session = authSupabaseDatasource.currentSession;
        if (session == null) {
          left(Failure('User is not present'));
        }
        return right(
          UserModel(
            name: '',
            email: session!.user.email ?? '',
            id: session.user.id,
          ),
        );
      }
      final res = await authSupabaseDatasource.getCurrentUser();
      if (res == null) {
        left(Failure('User is not present'));
      }
      return right(res);
    } on ServerExecption catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
