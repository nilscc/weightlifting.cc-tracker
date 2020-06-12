import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weightlifting.cc/pages/workout/exercises.dart';
import 'package:weightlifting.cc/pages/workout/workout_details.dart';

class SaveButton extends StatelessWidget {
  final BuildContext context;

  SaveButton(this.context);

  // Change notifier getters
  WorkoutDetails get details =>
      Provider.of<WorkoutDetails>(context, listen: false);
  ExercisesState get exercises =>
      Provider.of<ExercisesState>(context, listen: false);

  bool get _isModified => details.isModified || exercises.isModified;

  void _save() {
    print('SAVE - Details: [${details.dateTime}] "${details.title}"');
    print('     - Exercises: ${exercises.count}');

    // TODO: convert change notifier states into JSON and store on local storage

    exercises.unsetIsModified();
  }

  @override
  Widget build(BuildContext context) => FlatButton(
        child: Icon(
          Icons.save,
          color: _isModified ? Colors.white70 : Theme.of(context).disabledColor,
        ),
        onPressed: _save,
      );
}
