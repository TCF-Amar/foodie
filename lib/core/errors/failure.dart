/// Base class for all domain-level failures.
abstract class Failure {
  const Failure(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

// ─── Shared Failures ──────────────────────────────────────────────────────────

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong. Try again.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local data unavailable.']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Session expired. Please login again.',
  ]);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unexpected error occurred.']);
}

class OtpSendFailure extends Failure {
  const OtpSendFailure([super.message = 'Failed to send OTP.']);
}

class OtpVerifyFailure extends Failure {
  const OtpVerifyFailure([super.message = 'Invalid or expired OTP.']);
}

class InvalidPhoneFailure extends Failure {
  const InvalidPhoneFailure([super.message = 'Enter a valid 10-digit phone number.']);
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure([super.message = 'User not found.']);
}