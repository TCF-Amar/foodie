import 'package:calling_app/core/utils/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  FutureResult<void> login(String phoneNumber);
  FutureResult<AuthResponse> verifyOtp(String phoneNumber, String otp);
  // ignore: strict_top_level_inference
  Result<User?> getCurrentUser();

  // Future<void> logout();
}
