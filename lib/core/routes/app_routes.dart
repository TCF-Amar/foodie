class RouteModel {
  final String name;
  final String path;

  RouteModel({required this.name, required this.path});
}

class AppRoutes {
  static final RouteModel splash = RouteModel(name: 'splash', path: '/');
  static final RouteModel login = RouteModel(name: 'login', path: '/login');
  static final RouteModel verifyOtp = RouteModel(
    name: 'verify_otp',
    path: '/verify-otp',
  );
  static final RouteModel register = RouteModel(
    name: 'register',
    path: '/register',
  );
  static final RouteModel location = RouteModel(
    name: 'location',
    path: '/location',
  );
  static final RouteModel home = RouteModel(name: 'home', path: '/home');

  static final RouteModel camera = RouteModel(name: 'camera', path: '/camera');
}
