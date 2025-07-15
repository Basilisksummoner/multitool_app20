import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'package:lottie/lottie.dart';
import '../shared/app_state.dart';
import '../shared/main_scaffold.dart';
import '../shared/text_styles.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  
  @override
  State<WeatherPage> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  Weather? myWeather;

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
  void initState() {
    super.initState();
    myWeather = WeatherState().weather;
  }


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Погода',
      child: Center(
        child: SingleChildScrollView(
          child: myWeather != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  myWeather!.cityName,
                  style: TextStyles.size(22),
                ),
                Text(
                  '${myWeather!.temperature.round()}°C',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Lottie.asset(getWeatherAnimation(myWeather?.mainCondition)),
              ],
            )
          : Center(
              child: Text(
              'No weather data available',
              style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}



            
