import 'package:calling_app/core/widgets/index.dart';
import 'package:calling_app/features/auth/presentation/controller/auth_controller.dart';
import 'package:calling_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: HomeAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText.large("Welcome to Calling App!"),
            const SizedBox(height: 16),
            AppText.medium("You have successfully logged in."),
            Obx(() {
              return Column(
                children: [
                  AppText.medium(
                    authController.user?.phone.toString() ?? "No phone number",
                    overflow: TextOverflow.clip,
                  ),
                  AppText.medium(
                    authController.user?.updatedAt.toString() ??
                        "No name available",
                    overflow: TextOverflow.clip,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
