import 'package:multitool_app/models/weather_model.dart';


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
}

class CurrencyState {
  static final CurrencyState instance = CurrencyState.internal();
  
  factory CurrencyState() => instance;
  
  CurrencyState.internal();
  
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