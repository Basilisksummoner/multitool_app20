// recieving data from WeatherAPI
class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName, 
    required this.temperature,
    required this.mainCondition
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      );
  }
}
class Coords {
  final double latitude;
  final double longitude;

  const Coords({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() => 'Coords(lat: $latitude, lon: $longitude)';
}