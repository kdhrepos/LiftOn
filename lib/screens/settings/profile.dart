import 'package:flutter/material.dart';
import 'package:lifton/global/state.dart';

class Profile extends StatelessWidget {
  final String? profileImageUrl;

  const Profile({
    super.key,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.blueGrey,
                child: Icon(
                  Icons.person,
                  size: 60.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    currentUser.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  currentUser.gender == 1
                      ? const Icon(Icons.male, color: Colors.blue)
                      : const Icon(Icons.female),
                  const SizedBox(width: 5),
                  currentUser.isTrainer == 0
                      ? const Icon(Icons.person, color: Colors.blue)
                      : const Icon(Icons.fitness_center, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                currentUser.email,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
          const SizedBox(
            width: 100,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentUser.weight != null) ...[
                    ListTile(
                      title: const Text(
                        'Weight',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Text(
                        currentUser.weight.toString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                  if (currentUser.bmi != null) ...[
                    ListTile(
                      title: const Text(
                        'BMI',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Text(
                        currentUser.bmi.toString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                  if (currentUser.fatMass != null) ...[
                    ListTile(
                      title: const Text(
                        'Fat Mass',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Text(
                        currentUser.fatMass.toString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                  if (currentUser.muscleMass != null) ...[
                    ListTile(
                      title: const Text(
                        'Muscle Mass',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Text(
                        currentUser.muscleMass.toString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
