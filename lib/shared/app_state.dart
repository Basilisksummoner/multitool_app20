import 'package:multitool_app/pages/models/weather_model.dart';

class AppState {
  static final AppState instance = AppState.internal();
  
  factory AppState() => instance;
  
  AppState.internal();

  String? city;
  double? latitude;
  double? longitude;
  Weather? weather;}