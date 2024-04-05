import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blogs_page.dart';
import 'package:blog_app/features/blog/presentation/pages/upload_blog_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router_constants.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouterConstants.loginPageRoughtPath,
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
        path: RouterConstants.homePageRoughtPath,
        pageBuilder: (context, state) => const MaterialPage(
          child: BlogPage(),
        ),
      ),
      GoRoute(
        path: RouterConstants.uploadBlogPageRoughtPath,
        pageBuilder: (context, state) => const MaterialPage(
          child: UploadBlogPage(),
        ),
      ),
    ],
  );
}
