import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import '../modules/weather_module.dart';
import 'package:multitool_app/config/config.dart';


class WeatherService {
  final String apiKey;

  WeatherService(this.apiKey);

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

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Служба геолокации отключена. Включите её в настройках телефона.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Разрешение на геолокацию отклонено.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Разрешение на геолокацию навсегда отклонено. Измените это в настройках.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getCurrentCity() async {
    try {
      final position = await getCurrentPosition();
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return place.locality ?? place.administrativeArea ?? 'Неизвестный город';
      } else {
        throw Exception('Город не найден по координатам');
      }
    } catch (e) {
      throw Exception('Ошибка определения города: $e');
    }
  }

  Future<Weather> getWeatherByLocation() async {
    final city = await getCurrentCity();
    return await getWeatherByCity(city);
  
  }
}