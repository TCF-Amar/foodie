import 'package:foodie/core/constant/colors/app_colors.dart';
import 'package:foodie/core/constant/images/app_images.dart';
import 'package:foodie/core/widgets/index.dart';
import 'package:foodie/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class VerifyOtpPage extends GetView<AuthController> {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark, // For iOS
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
            ),
            // ---------- Background Image ----------
            Positioned.fill(
              child: AppContainer(
                image: DecorationImage(
                  image: AssetImage(AppImages.loginBackground),
                  fit: BoxFit.cover,
                ),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3), // Dark overlay
                ),
              ),
            ),
            // ---------- Back Button (with its own SafeArea) ----------
            Positioned(
              top: 20,
              left: 20,
              child: SafeArea(
                child: AppButton.icon(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  borderRadius: 12,
                  width: 45,
                  height: 45,
                  onPressed: () => context.pop(),
                ),
              ),
            ),

            // ---------- Top Text Content (wrapped with SafeArea) ----------
            SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    AppText.custom(
                      "Verify OTP",
                      color: AppColors.textOnDark,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: AppText.custom(
                        "Enter the 6-digit code we sent to\n+91 ${controller.phoneNumberController.text}",
                        color: AppColors.textOnDark.withValues(alpha: 0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---------- Bottom OTP Container (NO SafeArea around it) ----------
            Positioned(
              bottom: MediaQuery.of(
                context,
              ).viewInsets.bottom, // ← Keyboard height
              left: 0,
              right: 0,
              child: SafeArea(
                child: AppContainer(
                  color: AppColors.bgPrimary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppText.medium("Enter Code"),
                      const SizedBox(height: 24),

                      // ---------- OTP Fields ----------
                      Row(
                        children: List.generate(
                          6,
                          (index) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: AppInputField.otp(
                                controller: controller.otpControllers[index],
                                focusNode: controller.otpFocusNodes[index],
                                onChanged: (value) {
                                  // Auto-focus next/previous field
                                  if (value.isNotEmpty && index < 5) {
                                    controller.otpFocusNodes[index + 1]
                                        .requestFocus();
                                  }
                                  if (value.isEmpty && index > 0) {
                                    controller.otpFocusNodes[index - 1]
                                        .requestFocus();
                                  }
                                  // Auto-verify when all 6 digits are filled
                                  final allFilled = controller.otpControllers
                                      .every((c) => c.text.isNotEmpty);
                                  if (allFilled) {
                                    controller.verify(context);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ---------- Verify Button ----------
                      AppButton(
                        width: double.infinity,
                        backgroundColor: AppColors.accent700,
                        label: 'Verify & Continue',
                        onPressed: () => controller.verify(context),
                      ),

                      const SizedBox(height: 24),

                      // ---------- Resend Section ----------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText.medium(
                            "Didn't receive code? ",
                            color: AppColors.textSecondary,
                          ),
                          Obx(() {
                            return GestureDetector(
                              onTap: controller.canResend.value
                                  ? () => controller.login(context)
                                  : null,
                              child: AppText.medium(
                                controller.canResend.value
                                    ? "Resend"
                                    : "Resend in ${controller.resendCountdown.value}s",
                                color: controller.canResend.value
                                    ? AppColors.accent700
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
