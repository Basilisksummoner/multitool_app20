import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:multitool_app/shared/app_state.dart';
import './services/weather_service.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    loadWeatherData();
  }
  Future<void> loadWeatherData() async {

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
      AppState().latitude = position.latitude;
      AppState().longitude = position.longitude;

  
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final city = placemarks.first.locality ?? 'Unknown';
      AppState().city = city;

      
      final weather = await WeatherService().getWeatherByCity(city);
      AppState().weather = weather;
    } catch(e) {
      debugPrint('Ошибка загрузки: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

      /*// 5. Навигация
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavBar()),
      );
    } catch (e) {
      debugPrint('Ошибка загрузки: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }*/