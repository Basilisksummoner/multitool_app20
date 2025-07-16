import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multitool_app/models/weather_model.dart';
import 'package:multitool_app/services/weather_service.dart';

class WeatherState {
  static final WeatherState instance = WeatherState.internal();
  
  factory WeatherState() => instance;
  
  WeatherState.internal();

  String? someCity;
  Coords? someCoords;
  Weather? weatherModel;
  
  String? get city => someCity;
  Coords? get coords => someCoords;
  Weather? get myWeather => weatherModel;


  Future loadWeatherData() async {

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

      
      final weather = await WeatherService().getWeatherByCity(city);
      WeatherState().weatherModel = weather;
    } catch (e) {
      print('Ошибка при загрузке данных о погоде: $e');
    }
  }
}

class CurrencyState {
  static final CurrencyState _instance = CurrencyState._internal();
  
  factory CurrencyState() => _instance;
  
  CurrencyState._internal();
  
  String fromDefault = 'USD';
  String toDefault = 'KGS';
  double conversionRate = 0.0;
  double totalAmount = 0.0;
  
  String get fromCurrency => fromDefault;
  set fromCurrency(String value) {
    fromDefault = value;
  }
  String get toCurrency => toDefault;
  set toCurrency(String value) {
    toDefault = value;
  }
  double get rate => conversionRate;
  set rate(double value) {
    conversionRate = value;
  }
  double get total => totalAmount;
  set total(double value) {
    totalAmount = value;
  }
}