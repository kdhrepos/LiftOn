import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lifton/global/fetch.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/models/plan.dart';
import 'package:lifton/screens/exercise/goal.dart';
import 'package:lifton/screens/exercise/make_goal.dart';
import 'package:lifton/screens/exercise/make_plan.dart';
import 'package:lifton/screens/exercise/plan.dart';
import 'package:lifton/screens/exercise/timer.dart';
import 'package:lifton/screens/main/main.dart';
import 'package:table_calendar/table_calendar.dart';

class Exercise extends StatefulWidget {
  const Exercise({super.key});

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  late Future<List<PlanModel>> planList;
  late List<int> checkList = [];

  @override
  void initState() {
    super.initState();
    planList = Fetcher.getPlans(_selectedDay);
  }

  void postConductedState() async {
    await dio.post("$server/check-plan", data: {
      "checkList": checkList,
    }).then((_) => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Main(
                selectedIdx: 1,
              ),
            ),
          ),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    planList = Fetcher.getPlans(selectedDay);
                    checkList.clear();
                  });
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const ExerciseTimer(),
              const SizedBox(
                height: 20,
              ),
              const Goal(),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: planList,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      checkList.add(snapshot.data!.elementAt(i).id);
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          for (PlanModel plan in snapshot.data!)
                            Hero(
                              tag: "",
                              child: Column(
                                children: [
                                  Plan(
                                    plan: plan,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              ),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    splashRadius: 1,
                    onPressed: postConductedState,
                    icon: const Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    color: Colors.white,
                    iconSize: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: const Text('Plan'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: SizedBox(
                        width: 500,
                        height: 300,
                        child: MakePlan(selectedDay: _selectedDay),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              child: const Text('Goal'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: MakeGoal(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
