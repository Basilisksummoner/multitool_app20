import 'package:flutter/material.dart';


class MainScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomNavigationBar;


  const MainScaffold({
    super.key,
    required this.title,
    required this.child,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: const Color.fromARGB(255, 242, 232, 232),
        ),
        backgroundColor: Colors.black,
        body: child
      )
    );
  }
}