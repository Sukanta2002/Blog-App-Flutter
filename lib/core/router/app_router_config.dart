import 'package:blog_app/core/router/router_constants.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouterConstants.homePageRoughtPath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: LogInPage());
        },
      ),
      GoRoute(
        path: RouterConstants.signUpPageRoutePath,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignUpPage(),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => const MaterialPage(
          child: Scaffold(
            body: Center(
              child: Text('Home Page'),
            ),
          ),
        ),
      ),
    ],
  );
}
