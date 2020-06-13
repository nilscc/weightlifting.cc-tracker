import 'package:flutter/material.dart';

import 'package:weightlifting.cc/state/workout_state.dart';

class SaveButton extends StatelessWidget {
  final BuildContext context;

  SaveButton(this.context);

  // Change notifier getters
  WorkoutState get workout => WorkoutState.of(context);

  void _save() {
    print('SAVE - Details: [${workout.dateTime}] "${workout.title}"');
    print('     - Exercises: ${workout.exercises.length}');

    // TODO: convert change notifier states into JSON and store on local storage

    workout.unsetIsModified();
  }

  @override
  Widget build(BuildContext context) => FlatButton(
        child: Icon(
          Icons.save,
          color: workout.isModified ? Colors.white70 : Theme.of(context).disabledColor,
        ),
        onPressed: _save,
      );
}
