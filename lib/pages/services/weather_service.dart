import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modules/weather_module.dart';
import 'package:multitool_app/config/config.dart';


class WeatherService {
  static final WeatherService instance = WeatherService.internal();
  factory WeatherService() => instance;
  WeatherService.internal();

  static final String apiKey = Config.weatherApiKey;

  Future<Weather> getWeatherByCity(String cityName) async {
    final url = Uri.parse('${Config.weatherBaseUrl}?q=$cityName&appid=${Config.weatherApiKey}&units=metric');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Ошибка загрузки данных: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }
}