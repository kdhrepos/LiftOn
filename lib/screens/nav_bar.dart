import 'package:flutter/material.dart';
import 'package:lifton/screens/community/posts.dart';
import 'package:lifton/screens/exercise/exercise_home.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);
  @override
  BottomAppBar build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
            color: Colors.blue,
          ),
          IconButton(
            icon: const Icon(Icons.fitness_center),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExerciseHome()),
              );
            },
            color: Colors.blue,
          ),
          IconButton(
            icon: const Icon(Icons.messenger),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Posts()),
              );
            },
            color: Colors.blue,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
