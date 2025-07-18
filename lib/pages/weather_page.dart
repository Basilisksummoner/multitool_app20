import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../shared/app_state.dart';
import 'other/main_scaffold.dart';
import '../text_styles.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  
  @override
  State<WeatherPage> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  final weather = WeatherState.instance.myWeather;


  // animations
  String getWeatherAnimation(String? mainCondition) {
      if (mainCondition == null) return 'assets/sunny.json';

      switch (mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/clouds.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/rain.json';
        case 'thunderstorm':
          return 'assets/thunder.json';
        case 'clear':
          return 'assets/sunny.json';
        default:
          return 'assets/sunny.json';
      }
    }


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Погода',
      child: Center(
        child: SingleChildScrollView(
          child: weather != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weather!.cityName,
                  style: TextStyles.size(22, FontWeight.w400),
                ),
                Text(
                  '${weather!.temperature.round()}°C',
                  style: TextStyles.size(32, FontWeight.bold)
                ),
                Lottie.asset(getWeatherAnimation(weather?.mainCondition)),
              ],
            )
          : Center(
              child: Text(
              'No weather data available',
              style: TextStyles.size(18, FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}



            
