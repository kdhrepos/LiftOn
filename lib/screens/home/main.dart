import 'package:flutter/material.dart';
import 'package:lifton/screens/community/posts.dart';
import 'package:lifton/screens/exercise/exercise_home.dart';
import 'package:lifton/screens/home/home.dart';
import 'package:lifton/screens/settings/setting_screen.dart';

class Main extends StatefulWidget {
  const Main({
    super.key,
  });

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int selectedIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  static const List<Widget> screens = <Widget>[
    Home(),
    ExerciseHome(),
    Posts(),
    Setting(),
  ];
  static const List<String> titleList = <String>[
    "Home",
    "Exercise",
    "Community",
    "Settings"
  ];

  void onTapped(int idx) {
    setState(() {
      selectedIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          titleList.elementAt(selectedIdx),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: screens.elementAt(selectedIdx),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Settings',
          ),
        ],
        onTap: onTapped,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: selectedIdx,
      ),
    );
  }
}
