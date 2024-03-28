import 'package:blog_app/core/router/app_router_config.dart';
import 'package:blog_app/core/secrets/supabase_secrets.dart';
import 'package:blog_app/core/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SuperbaseSecrets.supabaseUrl,
    anonKey: SuperbaseSecrets.anonKey,
  );
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
