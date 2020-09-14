import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weightlifting.cc/database/types.dart' as dbt;
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/modified_state.dart';

class WorkoutState extends ChangeNotifier {
  final BuildContext context;

  WorkoutState(this.context) : _exercises = [ExerciseState(context)];

  /// Get workout state of current context (provided via "ChangeNotifierProvider")
  static WorkoutState of(BuildContext context, {bool listen: false}) =>
      Provider.of<WorkoutState>(context, listen: listen);

  /*
   * File storage data
   *
   */

  int _databaseId;
  int get databaseId => _databaseId;

  Future<void> query(Database db, final int workoutId) async {

    // lookup database data
    final dbt.Workout w = await dbt.Workout.query(db, workoutId);

    // write DB data into current state
    _databaseId = w.id;
    _title = w.title;
    _dateTime = w.date;
    _hasTime = w.hasTime;

    // load exercises
    _exercises = await ExerciseState.queryByWorkoutId(context, db, workoutId);
  }

  /*
   * Internal meta data, e.g. modified status
   *
   */

  ModifiedState get _modifiedState => ModifiedState.of(context);

  set _modified(final bool newValue) => _modifiedState.modified = newValue;

  /*
   * Details (date, time, description...)
   *
   */

  String _title;

  String get title => _title;
  set title(String title) {
    if (_title != title) {
      _title = title;
      _modified = true;

      notifyListeners();
    }
  }

  DateTime _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;
  set dateTime(DateTime dateTime) {
    if (_dateTime != dateTime) {
      _dateTime = dateTime;
      _modified = true;

      notifyListeners();
    }
  }

  // time is a virtual getter/setter without associated member (part of _dateTime)
  TimeOfDay get time =>
      TimeOfDay(hour: _dateTime.hour, minute: _dateTime.minute);
  set time(TimeOfDay time) {
    if (this.time != time) {
      if (time != null) {
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            time.hour, time.minute);
        _hasTime = true;
      } else
        _hasTime = false;

      _modified = true;

      notifyListeners();
    }
  }

  bool _hasTime = false;

  bool get hasTime => _hasTime;
  set hasTime(bool hasTime) {
    if (_hasTime != hasTime) {
      _hasTime = hasTime;
      _modified = true;

      notifyListeners();
    }
  }

  /*
   * Exercise List
   *
   */

  List<ExerciseState> _exercises;

  UnmodifiableListView<ExerciseState> get exercises =>
      UnmodifiableListView(_exercises);

  /// Add new (empty) exercise
  void newExercise() {
    _exercises.add(ExerciseState(context));
    _modified = true;
    notifyListeners();
  }

  // Keep track of currently active, i.e. modifiable, set
  int _activeExerciseId = 0;

  /// Get ID of active exercise
  int get activeExerciseId => _activeExerciseId;

  /// Get state of active exercise
  ExerciseState get activeExercise => _exercises[activeExerciseId];

  /// Update active set and notify any listeners.
  set activeExerciseId(int idx) {
    _activeExerciseId = idx;

    for (int i = 0; i < exercises.length; ++i) {
      if (i != idx) exercises[i].activeSetId = null;
    }

    notifyListeners();
  }

  /// Check if current active exercise is the last exercise in the list of
  /// all exercises.
  bool get activeIsLast => activeExerciseId == (exercises.length - 1);

  void addExercise() {
    _exercises.add(ExerciseState(context));
    notifyListeners();
  }

  void removeExerciseId(int idx) {
    _exercises.removeAt(idx);

    // update active exercise selection
    if (_activeExerciseId == idx)
      _activeExerciseId = null;
    else if (_activeExerciseId > idx) _activeExerciseId--;

    _modified = true;

    notifyListeners();
  }
}
