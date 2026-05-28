import 'package:foodie/features/auth/presentation/bindings/auth_bindings.dart';
import 'package:foodie/features/home/presentation/bindings/home_binding.dart';
import 'package:foodie/core/supabase/init_supabase.dart';
import 'package:foodie/features/main/main_controller.dart';
import 'package:foodie/features/menu/presentation/bindings/menu_binding.dart';

class InitDi {
  static void init() {
    _coreDi();
    _featureDi();
  }

  static void _coreDi() async {
    await SupabaseService.initSupabase();

    // Supabase is already initialized in SupabaseService.initSupabase()
    // No need to create a duplicate client - use SupabaseService.client
  }

  static void _featureDi() {
    MainBinding.init();
    AuthBindings.init();
    HomeBinding.init();
    MenuBinding.init();
  }
}
