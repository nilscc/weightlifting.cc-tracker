import 'package:flutter/material.dart';

import 'add_workout.dart';
import 'workout.dart';

import '../json/workout.dart';

class WorkoutsPage extends StatefulWidget {
  WorkoutsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WorkoutsPageState createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  final List<Workout> _workouts = [
    Workout(DateTime(2020, 02, 14), "Snatch Singles", [
      Exercise(null, "Snatch", [
        Set(60, 3),
        Set(70, 2),
        Set(80, 1),
        Set(80, 1),
        Set(85, 1),
        Set(90, 1),
        Set(95, 1),
        Set(100, 1),
        Set(100, 1),
        Set(100, 1),
      ])
    ]),
    Workout(DateTime(2020, 02, 12), "Clean & Jerks", [
      Exercise(null, "Clean & Jerk", [
        Set(100, 1),
        Set(110, 1),
        Set(115, 1),
        Set(120, 1),
        Set(125, 1),
        Set(125, 1),
        Set(125, 1),
        Set(120, 1),
      ]),
      Exercise(null, "Front Squat", [
        Set(140, 1),
        Set(150, 1),
        Set(155, 1),
        Set(160, 1),
      ])
    ]),
  ];

  void _addWorkout() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddWorkoutPage()));
  }

  void _openWorkout(BuildContext context, Workout workout) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPage(workout: workout)));
  }

  Widget buildWorkout(Workout w, BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => _openWorkout(context, w),
        leading: Container(
          color: Colors.red,
          padding: EdgeInsets.all(6),
          //alignment: Alignment.center,
          child: Text("${w.date.day}",
            style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),
          ),
        ),
        title: Text(w.title),
        subtitle: Text("${w.date.day}.${w.date.month}.${w.date.year}"),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: _workouts.map((w) => buildWorkout(w,context)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addWorkout();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
