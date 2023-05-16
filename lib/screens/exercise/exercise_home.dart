import 'package:flutter/material.dart';
import 'package:lifton/screens/exercise/goal.dart';

class ExerciseHome extends StatelessWidget {
  const ExerciseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Text("Calendar here"),
          IconButton(
            iconSize: 100,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Goal()),
              );
            },
            icon: const Icon(Icons.g_mobiledata),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.pan_tool_sharp), // plan
          ),
        ],
      )),
    );
  }
}
