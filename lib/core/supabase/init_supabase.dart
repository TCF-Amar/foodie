import 'package:foodie/core/constant/env/env_config.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final log = Logger();

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();
  static Future<void> initSupabase() async {
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

  static SupabaseClient get client => Supabase.instance.client;
}
