// import 'package:flutter/material.dart';
// import 'package:lifton/global/state.dart';
// import 'package:lifton/global/util.dart';
// import 'package:lifton/screens/exercise/exercise/exercise_card.dart';

// class MakePlan extends StatefulWidget {
//   const MakePlan({Key? key}) : super(key: key);

//   @override
//   _MakePlanState createState() => _MakePlanState();
// }

// class _MakePlanState extends State<MakePlan> {
//   List<ExerciseCard> exerciseList = []; // List to store exercise data

//   void setData(ExerciseData workout, int index) {
//     setState(() {
//       exerciseList[index].workout = workout;
//     });
//   }

//   void addExerciseCard() {
//     setState(() {
//       exerciseList.add(ExerciseCard(
//         onDelete: removeExerciseCard,
//         index: exerciseList.length,
//         setData: setData,
//         workout: ExerciseData(
//           name: null,
//           set: null,
//           reps: null,
//           weight: null,
//         ),
//       ));
//     });
//   }

//   void removeExerciseCard(int index) {
//     print("present value");
//     for (ExerciseCard ex in exerciseList) {
//       ex.workout.showInfo();
//     }
//     print("remove : $index");
//     setState(() {
//       exerciseList.elementAt(index).workout.showInfo();
//       exerciseList.removeAt(index);
//       for (int i = 0; i < exerciseList.length; i++) {
//         exerciseList.elementAt(i).index = i;
//       }
//       print("after value");
//       for (int i = 0; i < exerciseList.length; i++) {
//         exerciseList.elementAt(i).workout.showInfo();
//       }
//     });
//   }

//   void postPlan() async {
//     List<Map<String, dynamic>> workouts = [];
//     for (ExerciseCard ex in exerciseList) {
//       Map<String, dynamic> workout = {
//         'name': ex.workout.name,
//         'set': ex.workout.set,
//         'reps': ex.workout.reps,
//         'weight': ex.workout.weight,
//       };
//       workouts.add(workout);
//     }
//     await dio.post("$server/post-plan", data: {
//       "userId": currentUser.id,
//       'name': ex.workout.name,
//       'set': ex.workout.set,
//       'reps': ex.workout.reps,
//       'weight': ex.workout.weight,
//     }).then((value) => {
//           Navigator.pop(context),
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Plan"),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: StatefulBuilder(
//                 builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 children: [
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: exerciseList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ExerciseCard(
//                         onDelete: removeExerciseCard,
//                         workout: exerciseList[index].workout,
//                         index: index,
//                         setData: setData,
//                       );
//                     },
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: addExerciseCard,
//                         icon: const Icon(Icons.add),
//                         color: Colors.blue,
//                       ),
//                       IconButton(
//                         onPressed: postPlan,
//                         icon: const Icon(Icons.check),
//                         color: Colors.blue,
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
