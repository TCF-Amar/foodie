import "package:foodie/core/routes/app_routes.dart";
import "package:foodie/core/widgets/app_keys.dart";
import "package:foodie/features/auth/presentation/pages/login_page.dart";
import "package:foodie/features/auth/presentation/pages/splash_screen.dart";
import "package:foodie/features/auth/presentation/pages/verify_otp_page.dart";
import "package:foodie/features/home/presentation/pages/home_page.dart";
import "package:go_router/go_router.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class AppRouter {
  static final router = GoRouter(
    navigatorKey: AppKeys.navigatorKey,

    initialLocation: AppRoutes.splash.path,
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;
      // final isVerifyingOtp = state.fullPath == AppRoutes.verifyOtp.path;

      if (isLoggedIn && state.fullPath == AppRoutes.login.path) {
        return AppRoutes.home.path;
      }

      if (!isLoggedIn && state.fullPath == AppRoutes.home.path) {
        return AppRoutes.login.path;
      }
      return null;
    },

    routes: [
      // splash screen
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        builder: (context, state) =>
            const SplashScreen(), // You can create a SplashScreen widget for this
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.verifyOtp.path,
        name: AppRoutes.verifyOtp.name,
        builder: (context, state) => const VerifyOtpPage(),
      ),

      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
