import 'package:flutter/material.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/screens/main/main.dart';

class MakePlan extends StatefulWidget {
  const MakePlan({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  final DateTime selectedDay;
  @override
  _MakePlanState createState() => _MakePlanState();
}

class _MakePlanState extends State<MakePlan> {
  TextEditingController nameController = TextEditingController();
  TextEditingController setController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  void postPlan() async {
    if (nameController.text.isEmpty ||
        setController.text.isEmpty ||
        weightController.text.isEmpty ||
        repsController.text.isEmpty) return;

    await dio
        .post("$server/post-plan", data: {
          "userId": currentUser.id,
          'name': nameController.text,
          'set': int.parse(setController.text),
          'reps': int.parse(repsController.text),
          'weight': double.parse(weightController.text),
          'isConducted': false,
          'date': widget.selectedDay.toString(),
        })
        .then((_) => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Main(
                    selectedIdx: 1,
                  ),
                ),
              ),
            })
        .catchError((err) => {
              print(err),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Set Your Plan"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: setController,
                        decoration: const InputDecoration(
                          labelText: 'Set',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller: weightController,
                        decoration: const InputDecoration(
                          labelText: 'Weight (kg)',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller: repsController,
                        decoration: const InputDecoration(
                          labelText: 'Reps',
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: postPlan,
                  icon: const Icon(Icons.check),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
