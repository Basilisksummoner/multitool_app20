import 'package:flutter/material.dart';
import './weather_page.dart';
import './currency_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MultiTool App 2.0'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Погода'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WeatherPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Валютный калькулятор'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CurrencyPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}