import 'package:flutter_dotenv/flutter_dotenv.dart';


class Config {
  static final String weatherApiKey = dotenv.env['API_KEY_1'] ?? '';
  static final String weatherBaseUrl = dotenv.env['BASE_URL_1'] ?? '';
  static final String calcApiKey = dotenv.env['API_KEY_2'] ?? '';
  static final String urlForCurr = dotenv.env['URL_4_CURR'] ?? '';
  static final String urlForRates = dotenv.env['URL_4_RATES'] ?? '';
}


final Map<String, String> header = {
  "Content-Type" : "application/json"
};