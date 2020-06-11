import 'package:flutter/material.dart';

import '../json/workout.dart';

class WorkoutPage extends StatefulWidget {
  WorkoutPage({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

  Widget buildExercise(BuildContext context, Exercise exercise) {
    return Card(
      child: ListTile(
        title: Text(exercise.name),
        subtitle: Column(
          children: exercise.sets.map((s) {
            return Text("${s.weight_kg} kg / ${s.repetitions}");
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.title),
      ),
      body: Column(
        children: widget.workout.exercises.map((e) => buildExercise(context, e)).toList(),
      ),
    );
  }
}
