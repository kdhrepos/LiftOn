import 'package:flutter/material.dart';

class GoalMaker extends StatelessWidget {
  const GoalMaker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text("Goal"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Weight',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'BMI',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fat Mass',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Muscle Mass',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
