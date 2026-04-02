import 'package:calling_app/core/constant/env/env_config.dart';
import 'package:calling_app/core/routes/app_router.dart';
import 'package:calling_app/core/supabase/init_supabase.dart';
import 'package:calling_app/core/theme/app_theme.dart';

import 'package:calling_app/core/widgets/index.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  EnvConfig.init(env);

  await intiSupabase();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: AppKeys.messengerKey,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      // initialRoute: AppRoutes.login.path,
    );
  }
}
