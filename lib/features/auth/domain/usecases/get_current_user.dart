import 'package:foodie/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repo;
  GetCurrentUser({required this.repo});
  // ignore: strict_top_level_inference
  call() {
    return repo.getCurrentUser();
  }
}
