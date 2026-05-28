import 'package:foodie/features/auth/domain/repositories/auth_repository.dart';

import 'package:foodie/core/utils/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetCurrentUser {
  final AuthRepository repo;
  GetCurrentUser({required this.repo});
  Result<User?> call() {
    return repo.getCurrentUser();
  }
}
