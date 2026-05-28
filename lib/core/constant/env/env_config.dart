import 'package:logger/logger.dart';

import 'app_env.dart';
import 'dev_env.dart';
import 'prod_env.dart';

final log = Logger();

class EnvConfig {
  static late AppEnv _env;
  static bool _initialized = false;

  static void init(String envType) {
    if (_initialized) return;

    switch (envType) {
      case 'dev':
        _env = DevEnv();
        log.i('Environment: $envType');
        break;
      case 'prod':
        _env = ProdEnv();
        log.i('Environment: $envType');
        break;
      default:
        _env = DevEnv();
        log.i('Environment: $envType');
    }
    _initialized = true;
  }

  static AppEnv get instance => _env;
}
