import 'package:blog_app/core/common/cubits/user_cubit/user_cubit.dart';
import 'package:blog_app/core/network/internet_connection_checker.dart';
import 'package:blog_app/core/secrets/supabase_secrets.dart';
import 'package:blog_app/features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/signup_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasource/blog_local_datasource.dart';
import 'package:blog_app/features/blog/data/datasource/blog_supabash_datasource.dart';
import 'package:blog_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecase/get_all_blog_usecase.dart';
import 'package:blog_app/features/blog/domain/usecase/upload_blog_usecase.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: SuperbaseSecrets.supabaseUrl,
    anonKey: SuperbaseSecrets.anonKey,
  );
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'blogs'),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => InternetConnection(),
    )
    // Data source
    ..registerFactory<AuthSupabaseDatasource>(
      () => AuthSupabaseDatasourceImpl(
        serviceLocator(),
      ),
    )
    // repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecasses
    ..registerFactory<GetCurrentUserUsecase>(
      () => GetCurrentUserUsecase(
        serviceLocator(),
      ),
    )
    ..registerFactory<SignUpUsecase>(
      () => SignUpUsecase(
        serviceLocator(),
      ),
    )
    ..registerFactory<LoginUsecase>(
      () => LoginUsecase(
        authRepository: serviceLocator(),
      ),
    )
    // Auth bloc
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        signUpUsecase: serviceLocator(),
        loginUsecase: serviceLocator(),
        currentUserUsecase: serviceLocator(),
        userCubit: serviceLocator(),
      ),
    )

    // user cubit
    ..registerLazySingleton<UserCubit>(() => UserCubit());
}

void _initBlog() {
  serviceLocator
    // Data source
    ..registerFactory<BlogSupabaseDatasource>(
      () => BlogSupabaseDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<BlogLoaclDatasouece>(
      () => BlogLoaclDatasoueceImpl(
        serviceLocator(),
      ),
    )
    // repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogSupabaseDatasource: serviceLocator(),
        blogLoaclDatasouece: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory<UploadBlogUsecase>(
      () => UploadBlogUsecase(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogUsecase(
        blogRepository: serviceLocator(),
      ),
    )
    // blog Bloc
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        uploadBlogUsecase: serviceLocator(),
        getAllBlogUsecase: serviceLocator(),
      ),
    );
}
