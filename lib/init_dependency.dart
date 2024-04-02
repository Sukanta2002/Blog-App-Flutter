import 'package:blog_app/core/secrets/supabase_secrets.dart';
import 'package:blog_app/features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/signup_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SuperbaseSecrets.supabaseUrl,
    anonKey: SuperbaseSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );
}

void _initAuth() {
  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      signUpUsecase: serviceLocator(),
      loginUsecase: serviceLocator(),
      currentUserUsecase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<SignUpUsecase>(
    () => SignUpUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<LoginUsecase>(
    () => LoginUsecase(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthSupabaseDatasource>(
    () => AuthSupabaseDatasourceImpl(
      serviceLocator(),
    ),
  );
}
