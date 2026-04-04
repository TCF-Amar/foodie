import 'package:foodie/core/constant/colors/app_colors.dart';
import 'package:foodie/core/constant/images/app_images.dart';
import 'package:foodie/core/widgets/index.dart';
import 'package:foodie/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark, // For iOS
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Prevents background from resizing
        body: Stack(
          children: [
            Positioned.fill(
              child: AppContainer(
                image: DecorationImage(
                  image: AssetImage(AppImages.loginBackground),
                  fit: BoxFit.cover,
                ),
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      AppText.custom(
                        "Discover the Art \nof Delicious",
                        color: AppColors.textOnDark,
                        fontSize: 42,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      AppText.custom(
                        "Savor premium flavors from local favorites, \ndelivered with a touch of elegance.",
                        color: AppColors.textOnDark.withValues(alpha: 0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: SingleChildScrollView(
                  reverse: true, // Scrolls to keep focused field visible
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(
                        context,
                      ).viewInsets.bottom, // Keyboard height
                    ),
                    child: AppContainer(
                      color: AppColors.bgPrimary,
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(20),
                      //   topRight: Radius.circular(20),
                      // ),
                      // height: 300,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        spacing: 16,
                        children: [
                          AppText.medium("Login or Signup"),
                          AppInputField.phone(
                            borderColor: AppColors.borderMedium,
                            controller: controller.phoneNumberController,
                            focusedBorderWidth: 1,
                            prefixText: '+91 ',
                            fillColor: AppColors.bgSecondary,
                            maxLength: 10,
                          ),
                          AppButton(
                            width: double.infinity,
                            backgroundColor: AppColors.accent700,
                            label: 'Continue',
                            onPressed: () {
                              controller.login(context);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 16,
                            children: [
                              AppButton.icon(
                                backgroundColor: AppColors.surfaceVariant,
                                width: 50,
                                height: 50,
                                icon: Image.asset(
                                  AppImages.google,
                                  width: 25,
                                  height: 25,
                                ),
                                borderRadius: 100,
                                onPressed: () {},
                              ),
                              AppButton.icon(
                                backgroundColor: AppColors.surfaceVariant,
                                icon: Image.asset(
                                  AppImages.email,
                                  width: 25,
                                  height: 50,
                                ),
                                borderRadius: 100,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          AppText.small(
                            'By continuing, you agree to our Terms of Service and Privacy Policy',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
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
