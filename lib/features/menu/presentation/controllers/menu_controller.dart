import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMenuController extends GetxController with GetTickerProviderStateMixin {
  static const List<({String label, String? badge})> categories = [
    (label: "All", badge: null),
    (label: "Burger", badge: "New Flavours"),
    (label: "Pizza", badge: "NEW"),
    (label: "Sushi", badge: null),
    (label: "Drink", badge: "UPTO ₹100"),
    (label: "Snack", badge: null),
  ];

  // ── Reactive filter state ───────────────────────────────────────
  final RxBool vegOnly = false.obs;
  final RxBool nonVegOnly = false.obs;

  // ── Tab controller ──────────────────────────────────────────────
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: categories.length,
      vsync: this,
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // ── Filter toggles ──────────────────────────────────────────────
  void toggleVegOnly() {
    vegOnly.value = !vegOnly.value;
    if (vegOnly.value) nonVegOnly.value = false;
  }

  void toggleNonVegOnly() {
    nonVegOnly.value = !nonVegOnly.value;
    if (nonVegOnly.value) vegOnly.value = false;
  }
}
