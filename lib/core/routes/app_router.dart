import "package:calling_app/core/routes/app_routes.dart";
import "package:calling_app/core/widgets/app_keys.dart";
import "package:calling_app/features/auth/presentation/pages/login_page.dart";
import "package:go_router/go_router.dart";

class AppRouter {
  static final router = GoRouter(
    navigatorKey: AppKeys.navigatorKey,

    initialLocation: AppRoutes.login.path,
    routes: [
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      // GoRoute(
      //   path: AppRoutes.register.path,
      //   name: AppRoutes.register.name,
      //   builder: (context, state) => const RegisterPage(),
      // ),
      // GoRoute(
      //   path: AppRoutes.home.path,
      //   name: AppRoutes.home.name,
      //   builder: (context, state) => const HomePage(),
      // ),
    ],
  );
}
