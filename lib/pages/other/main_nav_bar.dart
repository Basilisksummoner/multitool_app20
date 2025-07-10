import 'package:flutter/material.dart';
import '/pages/weather_page.dart';
import '/pages/currency_page.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    WeatherPage(),
    CurrencyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Погода',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Валюта',
          )
        ],
      ),
    );
  }
}
