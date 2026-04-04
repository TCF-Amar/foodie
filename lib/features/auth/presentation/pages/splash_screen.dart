import 'package:foodie/core/routes/app_routes.dart';
import 'package:foodie/core/supabase/init_supabase.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();
  Future.delayed(const Duration(seconds: 2), () {
    if (!context.mounted) return;
    final session = SupabaseService.client.auth.currentSession;
    if (session != null) {
      // ignore: use_build_context_synchronously
      context.goNamed(AppRoutes.home.name);
    } else {
      // ignore: use_build_context_synchronously
      context.goNamed(AppRoutes.login.name);
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Foodie",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
