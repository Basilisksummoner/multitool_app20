import 'package:multitool_app/pages/modules/weather_module.dart';

class AppState {
  static final AppState instance = AppState.internal();
  
  factory AppState() => instance;
  
  AppState.internal();

  String? city;
  double? latitude;
  double? longitude;
  Weather? weather;
}