import 'package:calling_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:calling_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:calling_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:calling_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:calling_app/features/auth/domain/usecases/send_otp.dart';
import 'package:calling_app/features/auth/domain/usecases/verify_otp.dart';
import 'package:calling_app/features/auth/presentation/controller/auth_controller.dart';
import 'package:get/get.dart';

class AuthBindings {
  static void init() {
    Get.put<AuthRemoteDatasource>(AuthRemoteDatasourceImpl());
    Get.put<AuthRepository>(
      AuthRepositoryImpl(authRemoteDatasource: Get.find()),
    );
    Get.put<SendOtp>(SendOtp(repo: Get.find()));
    Get.put<VerifyOtp>(VerifyOtp(repo: Get.find()));
    Get.put<GetCurrentUser>(GetCurrentUser(repo: Get.find()));
    Get.put<AuthController>(
      AuthController(
        sendOtp: Get.find(),
        verifyOtp: Get.find(),
        getCurrentUser: Get.find(),
      ),
    );
  }
}
