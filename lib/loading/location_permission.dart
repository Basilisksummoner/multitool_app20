import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multitool_app/api_methods/weather_method.dart';
import 'package:multitool_app/models/weather_model.dart';
import 'package:multitool_app/shared/app_state.dart';



Future getPermission() async {

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
      WeatherState().someCoords = Coords(
        latitude: position.latitude,
        longitude: position.longitude,
      );

  
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final city = placemarks.first.locality ?? 'Unknown';
      WeatherState().someCity = city;

      
      final weather = await WeatherMethod().getWeatherByCity(city);
      WeatherState().weatherModel = weather;
    } catch (e) {
      print('Ошибка при загрузке данных о погоде: $e');
    }
  }