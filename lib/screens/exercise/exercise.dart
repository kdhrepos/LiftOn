import 'package:flutter/material.dart';
import 'package:lifton/fetch/plan_fetch.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/models/plan.dart';
import 'package:lifton/screens/exercise/goal.dart';
import 'package:lifton/screens/exercise/make_goal.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lifton/screens/exercise/widget/exercise_card.dart';

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
  List<ExerciseCard> exerciseList = [];

  void postPlan(PlanModel plan) async {
    await dio.post("$server/post-plan", data: {
      "userId": currentUser.id,
      'name': plan.name,
      'set': plan.set,
      'reps': plan.reps,
      'weight': plan.weight,
    });
  }

  void setData(PlanModel plan, int index) {
    setState(() {
      exerciseList[index].plan = plan;
    });
  }

  void addExerciseCard() {
    setState(() {
      exerciseList.add(ExerciseCard(
        onDelete: removeExerciseCard,
        index: exerciseList.length,
        setData: setData,
        postPlan: postPlan,
      ));
    });
  }

  void removeExerciseCard(int index) {
    // print("present value");
    // for (ExerciseCard ex in exerciseList) {
    //   ex.workout.showInfo();
    // }
    // print("remove : $index");
    setState(() {
      // exerciseList.elementAt(index).workout.showInfo();
      exerciseList.removeAt(index);
      for (int i = 0; i < exerciseList.length; i++) {
        exerciseList.elementAt(i).index = i;
      }
      // print("after value");
      // for (int i = 0; i < exerciseList.length; i++) {
      //   exerciseList.elementAt(i).workout.showInfo();
      // }
    });
  }

  @override
  void initState() {
    super.initState();
    planList = PlanFetch.getPlans(_selectedDay);
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
                    planList = PlanFetch.getPlans(selectedDay);
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
              const Goal(),
              // FutureBuilder(
              //   future: planList,
              //   builder: ((context, snapshot) {
              //     if (snapshot.hasData) {
              //       return SingleChildScrollView(
              //         child: Column(
              //           children: [
              //             for (PlanModel plan in snapshot.data!)
              //               const SizedBox(
              //                 height: 20,
              //               ),
              //           ],
              //         ),
              //       );
              //     }
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   }),
              // ),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: StatefulBuilder(
              //         builder: (BuildContext context, StateSetter setState) {
              //       return Column(
              //         children: [
              //           ListView.builder(
              //             shrinkWrap: true,
              //             physics: const NeverScrollableScrollPhysics(),
              //             itemCount: exerciseList.length,
              //             itemBuilder: (BuildContext context, int index) {
              //               return Column(
              //                 children: [
              //                   ExerciseCard(
              //                     onDelete: removeExerciseCard,
              //                     postPlan: postPlan,
              //                     index: index,
              //                     setData: setData,
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                 ],
              //               );
              //             },
              //           ),
              //         ],
              //       );
              //     }),
              //   ),
              // ),
              // IconButton(
              //   onPressed: addExerciseCard,
              //   icon: const Icon(Icons.add),
              //   color: Colors.blue,
              // ),
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
