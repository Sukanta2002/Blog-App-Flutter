import 'package:blog_app/core/common/cubits/user_cubit/user_cubit.dart';
import 'package:blog_app/core/router/app_router_config.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<UserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsLoggedin());
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserCubit, UserState, bool>(
      selector: (state) {
        return state is UserPresent;
      },
      builder: (context, state) {
        if (state) {
          AppRouter.router.go(RouterConstants.homePageRoughtPath);
        }

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Blog App',
          theme: AppTheme.theme,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
