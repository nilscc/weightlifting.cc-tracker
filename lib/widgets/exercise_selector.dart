import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/change_notifier/new_workout.dart';
import 'package:provider/provider.dart';

class ExerciseSelectorWidget extends StatelessWidget {
  ExerciseSelectorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> exercises = NewWorkout.exercises();

    return Card(child: Text('tbd'));
  }
}
