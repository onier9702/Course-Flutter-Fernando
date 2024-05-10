import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String baseUrl = dotenv.env['BASE_URL'] ?? 'The BASE_URL is not configured';

}
