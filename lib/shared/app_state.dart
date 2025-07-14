import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multitool_app/pages/models/weather_model.dart';
import 'package:multitool_app/pages/services/weather_service.dart';

class AppState {
  static final AppState instance = AppState.internal();
  
  factory AppState() => instance;
  
  AppState.internal();

  String? city;
  Coords? coords;
  Weather? weather;}

Future<void> loadWeatherData() async {

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Геолокация отключена');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Разрешение отклонено');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Разрешение навсегда отклонено');
      }

      final position = await Geolocator.getCurrentPosition();
      AppState().coords = Coords(
        latitude: position.latitude,
        longitude: position.longitude,
      );

  
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final city = placemarks.first.locality ?? 'Unknown';
      AppState().city = city;

      
      final weather = await WeatherService().getWeatherByCity(city);
      AppState().weather = weather;
    } catch (e) {
      print('Ошибка при загрузке данных о погоде: $e');
    }
}