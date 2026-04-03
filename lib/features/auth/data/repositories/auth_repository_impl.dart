import 'package:calling_app/core/errors/failure.dart';
import 'package:calling_app/core/utils/result.dart';
import 'package:calling_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:calling_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final log = Logger();

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImpl({required this.authRemoteDatasource});
  @override
  FutureResult<void> login(String phoneNumber) async {
    try {
      await authRemoteDatasource.login(phoneNumber);
      return Right(null);
    } on AuthException catch (e) {
      log.e(e.toString());
      return Left(OtpSendFailure(e.message));
    } catch (e) {
      log.e(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  FutureResult<AuthResponse> verifyOtp(String phoneNumber, String otp) async {
    try {
      final response = await authRemoteDatasource.verifyOtp(phoneNumber, otp);
      return Right(response);
    } on AuthException catch (e) {
      log.e(e.toString());
      return Left(OtpVerifyFailure(e.message));
    } catch (e) {
      log.e(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<User?> getCurrentUser() {
    try {
      final user = authRemoteDatasource.getCurrentUser();
      return Right(user);
    } on AuthException catch (e) {
      log.e(e.toString());
      return Left(UserNotFoundFailure(e.message));
    } catch (e) {
      log.e(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
