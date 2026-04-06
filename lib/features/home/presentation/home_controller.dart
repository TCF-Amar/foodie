import 'package:get/get.dart';

class HomeController extends GetxController {
  Future<void> refreshData() async {
    try {
      print("refreshing");
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      print("refreshed successfully");
    } catch (e) {
      print("refresh error: $e");
      rethrow;
    }
  }
}
