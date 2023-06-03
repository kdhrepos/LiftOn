import 'package:flutter/material.dart';
import 'package:lifton/models/plan.dart';

class Plan extends StatefulWidget {
  Plan({
    Key? key,
    required this.plan,
  }) : super(key: key);

  PlanModel plan;

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.plan.isConducted ? Colors.grey.shade200 : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      splashRadius: 1.0,
                      onPressed: () {
                        setState(() {
                          widget.plan.isConducted
                              ? widget.plan.isConducted = false
                              : widget.plan.isConducted = true;
                        });
                      },
                      icon: widget.plan.isConducted
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.plan.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.format_list_numbered),
                  title: Text('Sets: ${widget.plan.set}'),
                ),
                ListTile(
                  leading: const Icon(Icons.repeat_sharp),
                  title: Text('Reps: ${widget.plan.reps}'),
                ),
                ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: Text('Weight: ${widget.plan.weight}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
