import 'package:calling_app/core/constant/env/env_config.dart';
import 'package:calling_app/core/dependency/init_di.dart';
import 'package:calling_app/core/routes/app_router.dart';
import 'package:calling_app/core/supabase/init_supabase.dart';
import 'package:calling_app/core/theme/app_theme.dart';

import 'package:calling_app/core/widgets/index.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark,
  //   ),
  // );
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  EnvConfig.init(env);

  await SupabaseService.initSupabase();
  InitDi.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: AppKeys.messengerKey,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
      // initialRoute: AppRoutes.login.path,
    );
  }
}
