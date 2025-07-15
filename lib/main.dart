import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/other/loading_page.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingPage()
    );
  }
}


PreferredSizeWidget defaultAppBar(String title) {
  return AppBar(
  title: Text(title),
  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  );
}