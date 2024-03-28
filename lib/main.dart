import 'package:blog_app/core/router/app_router_config.dart';
import 'package:blog_app/core/theme/theme.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
