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

  final List<ExerciseState> _exercises = [ExerciseState()];

  UnmodifiableListView<ExerciseState> get exercises =>
      UnmodifiableListView(_exercises);

  /// Add new (empty) exercise
  void newExercise() {
    _exercises.add(ExerciseState());
    _isModified = true;
    notifyListeners();
  }

  // Keep track of currently active, i.e. modifiable, set
  int _activeExercise = 0;

  /// Get ID of active exercise
  int get activeExerciseId => _activeExercise;

  /// Get state of active exercise
  ExerciseState get activeExercise => _exercises[activeExerciseId];

  /// Update active set and notify any listeners.
  set activeExerciseId(int idx) {
    _activeExercise = idx;
    notifyListeners();
  }

  /// Check if current active exercise is the last exercise in the list of
  /// all exercises.
  bool get activeIsLast => activeExerciseId == (exercises.length - 1);


}
