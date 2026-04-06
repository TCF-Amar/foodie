import 'dart:async';
import 'package:foodie/core/routes/app_routes.dart';
import 'package:foodie/core/widgets/app_snack_bar.dart';
import 'package:foodie/features/auth/domain/usecases/get_current_user.dart';
import 'package:foodie/features/auth/domain/usecases/send_otp.dart';
import 'package:foodie/features/auth/domain/usecases/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final log = Logger();

class AuthController extends GetxController {
  final phoneNumberController = TextEditingController();

  final otpControllers = List.generate(6, (index) => TextEditingController());
  final otpFocusNodes = List.generate(6, (index) => FocusNode());

  final SendOtp sendOtp;
  final VerifyOtp verifyOtp;
  final GetCurrentUser getCurrentUser;

  AuthController({
    required this.sendOtp,
    required this.verifyOtp,
    required this.getCurrentUser,
  });

  final RxBool isLoading = false.obs;
  final Rx<User?> _user = Rxn<User?>();
  User? get user => _user.value;
  final RxInt resendCountdown = 30.obs;
  final RxBool canResend = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    checkCurrentUser();
  }

  @override
  void onClose() {
    _timer?.cancel();
    phoneNumberController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void startResendTimer() {
    canResend.value = false;
    resendCountdown.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void login(BuildContext context) async {
    if (phoneNumberController.text.length != 10) {
      AppSnackBar.error(context, "Enter valid phone number");
      return;
    }
    isLoading.value = true;
    final result = await sendOtp.call(phoneNumberController.text);
    result.fold(
      (failure) {
        isLoading.value = false;
        AppSnackBar.error(context, failure.message);
      },
      (_) {
        isLoading.value = false;
        AppSnackBar.success(context, "OTP sent successfully");
        if (context.mounted) {
          context.goNamed(AppRoutes.verifyOtp.name);
        }
        startResendTimer();
      },
    );
  }

  void verify(BuildContext context) async {
    final otp = otpControllers.map((e) => e.text).join();
    if (otp.length != 6) {
      AppSnackBar.error(context, "Please enter 6-digit OTP");
      return;
    }

    final result = await verifyOtp.call(phoneNumberController.text, otp);
    result.fold(
      (failure) {
        AppSnackBar.error(context, failure.message);
      },
      (response) {
        _user.value = response.user;
        AppSnackBar.success(context, "Logged in successfully");
        if (context.mounted) {
          context.goNamed(AppRoutes.home.name);
        }
      },
    );
  }

  void checkCurrentUser() {
    final result = getCurrentUser.call(); // Result<User?> — synchronous
    result.fold(
      (failure) => log.e('Error fetching current user: ${failure.message}'),
      (user) => _user.value = user,
    );
  }

  bool isLoggedIn() {
    return _user.value != null;
  }
}
