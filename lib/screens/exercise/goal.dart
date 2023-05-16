import 'package:flutter/material.dart';
import 'package:lifton/screens/exercise/make_goal.dart';

class Goal extends StatelessWidget {
  const Goal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Datas Here"),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GoalMaker()),
                );
              },
              icon: const Icon(Icons.change_circle),
            ),
          ],
        ),
      ),
    );
  }
}
