import 'package:flutter/material.dart';
import 'services/weather_service.dart';
import 'modules/weather_module.dart';
import 'package:lottie/lottie.dart';
import 'package:multitool_app/config/config.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  
  @override
  State<WeatherPage> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  
  final weatherService = WeatherService(Config.weatherApiKey);
    Weather? myWeather;

  Future fetchWeather() async {
    try {
      String cityName = await weatherService.getCurrentCity();
      print('Город: $cityName');

      final weather = await weatherService.getWeatherByCity(cityName); // временно указываем London
      print('Погода получена: ${weather.cityName}, ${weather.temperature}°C');

      setState(() {
        myWeather = weather;
      });
    } catch (e) {
      print('Ошибка при получении погоды: $e');
    }
  }

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
      fetchWeather();
    }


  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Погода'),
          backgroundColor: const Color.fromARGB(255, 242, 232, 232),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Center(
                child: myWeather != null
                  ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        myWeather!.cityName,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
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
                    ]
                  )
                : CircularProgressIndicator(color: Colors.white),
              ),
      );
    }
}



            
