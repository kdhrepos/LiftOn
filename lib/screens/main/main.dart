import 'package:flutter/material.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/screens/community/posts.dart';
import 'package:lifton/screens/exercise/exercise.dart';
import 'package:lifton/screens/main/home.dart';
import 'package:lifton/screens/auth/start.dart';
import 'package:lifton/screens/settings/setting_screen.dart';

class Main extends StatefulWidget {
  Main({
    super.key,
    required this.selectedIdx,
  });
  int selectedIdx;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    if (widget.selectedIdx == 1) {
      screens[widget.selectedIdx] =
          isLoggedIn ? const Exercise() : const StartScreen();
    }
    if (widget.selectedIdx == 3) {
      screens[widget.selectedIdx] =
          isLoggedIn ? const Setting() : const StartScreen();
    }
    widget.selectedIdx = widget.selectedIdx;
  }

  List<Widget> screens = <Widget>[
    const Home(),
    const Exercise(),
    const Posts(),
    const Setting(),
  ];
  List<String> titleList = <String>[
    "Home",
    "Exercise",
    "Community",
    "Settings",
  ];

  void onTapped(int idx) {
    setState(() {
      if (idx == 1) {
        screens[idx] = isLoggedIn ? const Exercise() : const StartScreen();
      }
      if (idx == 3) {
        screens[idx] = isLoggedIn ? const Setting() : const StartScreen();
      }
      widget.selectedIdx = idx;
    });
  }

  void logout(int idx) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Logout",
          ),
          content: const Text("Sure?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isLoggedIn = false;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Main(
                      selectedIdx: idx,
                    ),
                  ),
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          titleList.elementAt(widget.selectedIdx),
        ),
        automaticallyImplyLeading: false,
        actions: [
          isLoggedIn
              ? IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    setState(() {
                      logout(0);
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const Dialog(
                          child: StartScreen(),
                        );
                      },
                    );
                  },
                ),
        ],
      ),
      body: Container(
        child: screens.elementAt(widget.selectedIdx),
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
        currentIndex: widget.selectedIdx,
      ),
    );
  }
}
