import 'package:foodie/core/constant/env/env_config.dart';
import 'package:foodie/core/dependency/init_di.dart';
import 'package:foodie/core/routes/app_router.dart';
import 'package:foodie/core/theme/app_theme.dart';

import 'package:foodie/core/widgets/index.dart';
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
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      // initialRoute: AppRoutes.login.path,
    );
  }
}
