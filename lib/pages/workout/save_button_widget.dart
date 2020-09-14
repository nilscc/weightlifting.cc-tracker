import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weightlifting.cc/database/storage.dart';

import 'package:weightlifting.cc/json/workout.dart' as json;
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/database_state.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/modified_state.dart';
import 'package:weightlifting.cc/state/set_state.dart';

import 'package:weightlifting.cc/state/workout_state.dart';

class SaveButtonWidget extends StatelessWidget {
  final BuildContext context;

  SaveButtonWidget(this.context);

  // Change notifier getters
  DatabaseState get _databaseState => DatabaseState.of(context);
  ModifiedState get _modifiedState => ModifiedState.of(context);
  WorkoutState get workout => WorkoutState.of(context);

  ExerciseMessages get _exerciseMessages => ExerciseMessages.of(context);

  void _save() async {
//    List<json.Exercise> exercises = [];
//
//    for (ExerciseState e in workout.exercises) {
//      List<json.Set> sets = [];
//
//      for (SetState s in e.sets) {
//        // add set to exercise set list
//        sets.add(json.Set(s.weight, s.reps));
//      }
//
//      // add exercise to workout exercise list
//      exercises.add(json.Exercise(
//          e.exerciseId, _exerciseMessages.exercise(e.exerciseId), sets));
//    }
//
//    // build final workout
//    json.Workout w = json.Workout(
//        workout.dateTime, workout.hasTime, workout.title, exercises);
//
//    // get database
//    Database db = await _databaseState.database;
//
//
//    // pick new file path if it doesn't exist yet
//    if (workout.workoutId == null) {
//      workout.workoutId = await insertWorkout(db, w);
//    }
//    else
//      updateWorkout(db, workout.workoutId, w);
//
//    print('Saved workout #${workout.workoutId}');
//
//    final String encoded = jsonEncode(w);
//    print(encoded);
//
//    _modifiedState.modified = false;
  }

  @override
  Widget build(BuildContext context) => FlatButton(
        child: Icon(
          Icons.save,
          color: ModifiedState.of(context, listen: true).modified
              ? Colors.white70
              : Theme.of(context).disabledColor,
        ),
        onPressed: _save,
      );
}
