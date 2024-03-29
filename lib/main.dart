import 'package:blog_app/core/router/app_router_config.dart';
import 'package:blog_app/core/secrets/supabase_secrets.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/usecase/signup_usercase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: SuperbaseSecrets.supabaseUrl,
    anonKey: SuperbaseSecrets.anonKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          signUpUsecase: SignUpUsecase(
            AuthRepositoryImpl(
              AuthSupabaseDatasourceImpl(
                supabase.client,
              ),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Blog App',
      theme: AppTheme.theme,
      routerConfig: AppRouter.router,
    );
  }
}
