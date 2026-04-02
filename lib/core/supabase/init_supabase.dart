import 'package:calling_app/core/constant/env/env_config.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final log = Logger();
Future<void> intiSupabase() async {
  try {
    await Supabase.initialize(
      url: EnvConfig.instance.supabaseUrl,
      anonKey: EnvConfig.instance.supabaseAnonKey,
    );
    log.i("Supabase initialized");
  } catch (e) {
    log.e("Supabase initialization failed: $e");
  }
}
