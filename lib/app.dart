import 'package:flutter/material.dart';
import 'package:lifton/screens/home/main.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main(
        selectedIdx: 0,
      ),
    );
  }
}
