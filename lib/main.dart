import 'package:flutter/material.dart';
import 'package:lifton/screens/home/home.dart';
import 'package:lifton/screens/home/start.dart';
import 'package:lifton/global/state.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoggedIn ? const Home() : const StartScreen(),
    );
  }
}
