class RouteModel {
  final String name;
  final String path;

  RouteModel({required this.name, required this.path});
}

class AppRoutes {
  static final RouteModel login = RouteModel(name: 'login', path: '/login');
  static final RouteModel register = RouteModel(
    name: 'register',
    path: '/register',
  );
  static final RouteModel home = RouteModel(name: 'home', path: '/home');
}
