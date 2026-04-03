import 'package:calling_app/core/utils/result.dart';
import 'package:calling_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyOtp {
  final AuthRepository repo;
  VerifyOtp({required this.repo});
  FutureResult<AuthResponse> call(String phoneNumber, String otp) {
    return repo.verifyOtp(phoneNumber, otp);
  }
}
