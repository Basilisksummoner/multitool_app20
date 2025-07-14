import 'package:flutter/material.dart';
import 'package:multitool_app/pages/services/weather_service.dart';
import 'modules/weather_module.dart';
import 'package:lottie/lottie.dart';
import '../shared/app_state.dart';


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
    myWeather = AppState().weather;
  }

  Future<void> refreshWeather() async {
    try {
      final city = AppState().city;
      if (city == null) throw Exception('Город не найден в AppState');

      final updatedWeather = await WeatherService().getWeatherByCity(city);
      AppState().weather = updatedWeather;

      if (!mounted) return;
      setState(() {
        myWeather = updatedWeather;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка обновления: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (myWeather == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
        );
      }
    return Scaffold(
      appBar: AppBar(
          title: const Text('Погода'),
          backgroundColor: const Color.fromARGB(255, 242, 232, 232),
        ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: SingleChildScrollView(
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



            
