import 'package:foodie/core/supabase/init_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDatasource {
  Future<void> login(String phoneNumber);
  Future<AuthResponse> verifyOtp(String phoneNumber, String otp);
  User? getCurrentUser();
  Session? getCurrentSession();
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final supabase = SupabaseService.client;

  AuthRemoteDatasourceImpl();
  static const String _defaultCountryCode = '+91';

  @override
  Future<void> login(String phoneNumber) async {
    await supabase.auth.signInWithOtp(phone: "${_defaultCountryCode}$phoneNumber");
  }

  @override
  Future<AuthResponse> verifyOtp(String phoneNumber, String otp) async {
    return await supabase.auth.verifyOTP(
      phone: "${_defaultCountryCode}$phoneNumber",
      token: otp,
      type: OtpType.sms,
    );
  }

  @override
  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }

  @override
  Session? getCurrentSession() {
    return supabase.auth.currentSession;
  }

  @override
  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
