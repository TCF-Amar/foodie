import 'package:calling_app/core/constant/env/app_env.dart';

class DevEnv implements AppEnv {
  @override
  String get supabaseUrl => "https://nuxeozrvfickvpgakkiu.supabase.co";

  @override
  String get supabasePublicKey =>
      'sb_publishable_82biv5vkMzvPKt07lr5ZKg_Jr4BMTpU';

  @override
  String get supabaseAnonKey =>
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im51eGVvenJ2Zmlja3ZwZ2Fra2l1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ2Nzg0OTQsImV4cCI6MjA5MDI1NDQ5NH0.G8yHAAjKWUYqxcbtY-udZQQyJ8xm_smTo6LoFYY6AoM';

  @override
  String get zegoAppId => '1729148317';

  @override
  String get zegoAppSign =>
      '22b66514c58931c30b54ae59560a7141d35f23ca3addcdaab9d37819c963f300';
}
