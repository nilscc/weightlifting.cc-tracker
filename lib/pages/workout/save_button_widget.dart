import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:weightlifting.cc/json/workout.dart' as json;
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/set_state.dart';

import 'package:weightlifting.cc/state/workout_state.dart';

class SaveButtonWidget extends StatelessWidget {
  final BuildContext context;

  SaveButtonWidget(this.context);

  // Change notifier getters
  WorkoutState get workout => WorkoutState.of(context);

  ExerciseMessages get _exerciseMessages => ExerciseMessages.of(context);

  void _save() async {
    List<json.Exercise> exercises = [];

    for (ExerciseState e in workout.exercises) {
      List<json.Set> sets = [];

      for (SetState s in e.sets) {
        // add set to exercise set list
        sets.add(json.Set(s.weight, s.reps));
      }

      // add exercise to workout exercise list
      exercises.add(json.Exercise(e.exerciseId, _exerciseMessages.exercise(e.exerciseId), sets));
    }

    // build final workout
    json.Workout w = json.Workout(workout.dateTime, workout.hasTime, workout.title, exercises);

    // pick new file path if it doesn't exist yet
    if (workout.filePath == null) {
      // get application directory
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      // create new file
      workout.filePath = '${appDocDirectory.path}/workout_${DateTime.now().hashCode}.json';
    }

    print('Saving workout to: ${workout.filePath}');

    final String encoded = jsonEncode(w);
    print(encoded);
    new File(workout.filePath).writeAsString(encoded);

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
