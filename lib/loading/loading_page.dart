import 'package:flutter/material.dart';
import 'package:multitool_app/api_methods/currency_method.dart';
import 'package:multitool_app/loading/location_permission.dart';
import 'package:multitool_app/shared/app_state.dart';
import '../main_nav_bar.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  
  final weather = WeatherState.instance;
  final currency = CurrencyState.instance;
  
  @override
  void initState() {
    super.initState();
    loadAll();
  }
  

  Future<void> loadAll() async {

    try {
      await Future.wait([
        getCurrencies(),
        getPermission()
      ]);

      
      if (weather.myWeather == null) {
        throw Exception('Не удалось загрузить данные о погоде');
      }
      if (currency.currenciesList.isEmpty) {
        throw Exception('Не удалось загрузить валютные данные');
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