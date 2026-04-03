import 'package:calling_app/core/errors/failure.dart';
import 'package:calling_app/core/utils/result.dart';
import 'package:calling_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SendOtp {
  final AuthRepository repo;
  SendOtp({required this.repo});
  FutureResult<void> call(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return Future.value(Left(const InvalidPhoneFailure()));
    }
    return repo.login(phoneNumber);
  }
}
