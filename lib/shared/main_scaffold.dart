import 'package:flutter/material.dart';


class MainScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const MainScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 242, 232, 232),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(child: child),
    );
  }
}