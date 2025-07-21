import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multitool_app/api_methods/currency_method.dart';
import 'package:multitool_app/api_methods/weather_method.dart';
import 'package:multitool_app/models/weather_model.dart';
import 'package:multitool_app/shared/app_state.dart';
import '../main_nav_bar.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  
  final weather = WeatherState.instance;
  
  @override
  void initState() {
    super.initState();
    tryToLoad();
    getCurrencies();
  }
  
  Future getPermission() async {

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

      
      final weather = await WeatherMethod().getWeatherByCity(city);
      WeatherState().weatherModel = weather;
    } catch (e) {
      print('Ошибка при загрузке данных о погоде: $e');
    }
  }
  
  Future<void> tryToLoad() async {

    try {
      await getPermission();
      if (weather.myWeather == null) {
        throw Exception('Не удалось загрузить данные о погоде');
      }
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NavBar()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Text(
          'MultiTool',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      )
    );
  }
}