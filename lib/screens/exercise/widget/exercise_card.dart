
import 'package:flutter/material.dart';
import 'package:lifton/models/plan.dart';

class ExerciseCard extends StatefulWidget {
  ExerciseCard({
    Key? key,
    required this.onDelete,
    required this.index,
    required this.setData,
    required this.postPlan,
  }) : super(key: key);

  int index;
  final Function(int) onDelete;
  final Function(PlanModel plan, int index) setData;
  final Function(PlanModel plan) postPlan;

  late PlanModel plan;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  TextEditingController nameController = TextEditingController();
  TextEditingController setController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial values of the controllers based on the workout data
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes the shadow position
          ),
        ],
        borderRadius: BorderRadius.circular(
            10), // adjusts the border radius of the container
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.onDelete(widget.index);
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.blue,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.save),
                      color: Colors.blue,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            widget.plan.set = int.parse(value);
                            widget.setData(widget.plan, widget.index);
                          });
                        },
                        controller: setController,
                        decoration: const InputDecoration(
                          labelText: 'Set',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            widget.plan.weight = double.parse(value);
                            widget.setData(widget.plan, widget.index);
                          });
                        },
                        controller: weightController,
                        decoration: const InputDecoration(
                          labelText: 'Weight (kg)',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            widget.plan.reps = int.parse(value);
                            widget.setData(widget.plan, widget.index);
                          });
                        },
                        controller: repsController,
                        decoration: const InputDecoration(
                          labelText: 'Reps',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
