// main_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainController extends GetxController {
  final pageController = PageController();
  final currentIndex = 0.obs;

  void onTap(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class MainBinding {
  static void init() {
    Get.lazyPut(() => MainController());
  }
}
