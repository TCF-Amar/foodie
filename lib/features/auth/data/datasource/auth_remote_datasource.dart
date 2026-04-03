import 'package:calling_app/core/supabase/init_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDatasource {
  Future<void> login(String phoneNumber);
  Future<AuthResponse> verifyOtp(String phoneNumber, String otp);
  User? getCurrentUser();
  Session? getCurrentSession();
  // Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final supabase = SupabaseService.client;

  AuthRemoteDatasourceImpl();
  @override
  Future<void> login(String phoneNumber) async {
    await supabase.auth.signInWithOtp(phone: "+91$phoneNumber");
  }

  @override
  Future<AuthResponse> verifyOtp(String phoneNumber, String otp) async {
    return await supabase.auth.verifyOTP(
      phone: "+91$phoneNumber",
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

  // @override
  // Future<void> logout() {
  //   // TODO: implement logout
  //   throw UnimplementedError();
  // }
}
