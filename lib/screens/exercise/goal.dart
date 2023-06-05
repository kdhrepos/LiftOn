import 'package:flutter/material.dart';
import 'package:lifton/global/fetch.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/models/goal.dart';

class Goal extends StatefulWidget {
  const Goal({super.key});

  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  GoalModel? userGoal;

  @override
  void initState() {
    super.initState();
    fetchUserGoal();
  }

  Future<void> fetchUserGoal() async {
    try {
      final goal = await Fetcher.getUserGoal(currentUser.id);
      setState(() {
        userGoal = goal;
      });
    } catch (error) {
      print('Failed to fetch user goal: $error');
      // Handle the error condition
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userGoal == null) {
      return const Text(
        "Set Your Goal!",
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 30,
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Goal",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      'Weight: ${userGoal!.weight}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      'BMI: ${userGoal!.bmi}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      'Fat Mass: ${userGoal!.fatMass}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      'Muscle Mass: ${userGoal!.muscleMass}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
