import 'package:foodie/features/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding {
  static void init() {
    Get.lazyPut(() => HomeController());
  }
}
