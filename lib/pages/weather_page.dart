import 'package:flutter/material.dart';
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
      if (myWeather == null) {
        print('Weather is null in WeatherPage');
      } else {
        print('Weather loaded in WeatherPage: ${myWeather!.temperature}');
      }
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



            
