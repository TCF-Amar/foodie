import 'package:get/get.dart';
import 'package:foodie/features/menu/presentation/controllers/menu_controller.dart';

class MenuBinding {
  static void init() {
    Get.lazyPut(() => AppMenuController());
  }
}
