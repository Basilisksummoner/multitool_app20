import 'package:flutter_dotenv/flutter_dotenv.dart';

final Map<String, String> header = {
  "Content-Type" : "application/json"
};

class Config {
  static final String weatherApiKey = dotenv.env['API_KEY_1'] ?? '';
  static final String weatherBaseUrl = dotenv.env['BASE_URL_1'] ?? '';
  static final String calcApiKey = dotenv.env['API_KEY_2'] ?? '';
  static final String baseUrlCurr = dotenv.env['URL_4_CURR'] ?? '';

   static String urlForCurr(String from) {
    return '$baseUrlCurr/$calcApiKey/latest/$from';
  }
}