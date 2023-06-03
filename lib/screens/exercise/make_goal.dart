import 'package:flutter/material.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/screens/home/main.dart';

class MakeGoal extends StatefulWidget {
  const MakeGoal({Key? key}) : super(key: key);

  @override
  State<MakeGoal> createState() => _MakeGoalState();
}

class _MakeGoalState extends State<MakeGoal> {
  TextEditingController weightController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController fatMassController = TextEditingController();
  TextEditingController muscleMassController = TextEditingController();

  void postGoal() async {
    if (weightController.text.isNotEmpty &&
        bmiController.text.isNotEmpty &&
        fatMassController.text.isNotEmpty &&
        muscleMassController.text.isNotEmpty) {
      double weight = double.parse(weightController.text);
      double bmi = double.parse(bmiController.text);
      double fatMass = double.parse(fatMassController.text);
      double muscleMass = double.parse(muscleMassController.text);
      await dio.post("$server/post-goal", data: {
        "userId": currentUser.id,
        "weight": weight,
        "bmi": bmi,
        "fatMass": fatMass,
        "muscleMass": muscleMass,
      }).then((response) {
        setState(() {
          weightController.clear();
          bmiController.clear();
          fatMassController.clear();
          muscleMassController.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Main(
                selectedIdx: 1,
              ),
            ),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Set Your Goal"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Weight',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: bmiController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'BMI',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: fatMassController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fat Mass',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: muscleMassController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Muscle Mass',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                onPressed: postGoal,
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
