import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';

class WorkoutState extends ChangeNotifier {
  /// Get workout state of current context (provided via "ChangeNotifierProvider")
  static WorkoutState of(BuildContext context) =>
      Provider.of<WorkoutState>(context, listen: false);

  /*
   * Internal meta data, e.g. modified status
   *
   */

  // Keep modified status protected as private member
  bool _isModified = false;

  /// Workout is modified if its details or any of its exercises are modified.
  bool get isModified => _isModified || _exercises.any((exc) => exc.isModified);

  /// Unset modified status, e.g. after saving all data to JSON files.
  void unsetIsModified() {
    _isModified = false;
    _exercises.forEach((e) => e.unsetIsModified());

    // No need to modify listeners...
  }

  /*
   * Details (date, time, description...)
   *
   */

  String _title;
  DateTime _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;
  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
    _isModified = true;
    notifyListeners();
  }

  String get title => _title;
  set title(String title) {
    _title = title;
    _isModified = true;
    notifyListeners();
  }

  /*
   * Exercise List
   *
   */

  int get count => 0;

  final List<ExerciseState> _exercises = [ExerciseState()];

  UnmodifiableListView<ExerciseState> get exercises =>
      UnmodifiableListView(_exercises);

  void addExercise() {
    _exercises.add(ExerciseState());
    _isModified = true;
    notifyListeners();
  }

  int _activeSet = 0;
  int get activeSet => _activeSet;
  set activeSet(int idx) {
    _activeSet = idx;
    notifyListeners();
  }
}
