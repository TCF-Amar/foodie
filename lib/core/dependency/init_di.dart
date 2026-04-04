import 'package:foodie/core/constant/env/env_config.dart';
import 'package:foodie/features/auth/presentation/bindings/auth_bindings.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InitDi {
  static void init() {
    _coreDi();
    _featureDi();
  }

  static void _coreDi() {
    Get.put(
      SupabaseClient(
        EnvConfig.instance.supabaseUrl,
        EnvConfig.instance.supabaseAnonKey,
      ),
    );
  }

  static void _featureDi() {
    AuthBindings.init();
  }
}
