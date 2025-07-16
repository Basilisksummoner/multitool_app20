import 'package:flutter/material.dart';
import 'package:multitool_app/services/currency_service.dart';
import 'package:multitool_app/shared/app_state.dart';
import 'main_nav_bar.dart';


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
    getCurrencies(setState);
  }
  
  Future<void> tryToLoad() async {

    try {
      await weather.loadWeatherData();
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