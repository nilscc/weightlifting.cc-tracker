import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';

class WorkoutState extends ChangeNotifier {
  /// Get workout state of current context (provided via "ChangeNotifierProvider")
  static WorkoutState of(BuildContext context, {bool listen: false}) =>
      Provider.of<WorkoutState>(context, listen: listen);

  /*
   * File storage data
   *
   */

  String filePath;

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

  String get title => _title;
  set title(String title) {
    if (_title != title) {
      _title = title;
      _isModified = true;

      notifyListeners();
    }
  }

  DateTime _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;
  set dateTime(DateTime dateTime) {
    if (_dateTime != dateTime) {
      _dateTime = dateTime;
      _isModified = true;

      notifyListeners();
    }
  }

  // time is a virtual getter/setter without associated member (part of _dateTime)
  TimeOfDay get time => TimeOfDay(hour: _dateTime.hour, minute: _dateTime.minute);
  set time(TimeOfDay time) {
    if (this.time != time) {
      if (time != null) {
        _dateTime = DateTime(
            _dateTime.year, _dateTime.month, _dateTime.day, time.hour,
            time.minute);
        _hasTime = true;
      }
      else
        _hasTime = false;

      _isModified = true;

      notifyListeners();
    }
  }

  bool _hasTime = false;

  bool get hasTime => _hasTime;
  set hasTime(bool hasTime) {
    if (_hasTime != hasTime) {
      _hasTime = hasTime;
      _isModified = true;

      notifyListeners();
    }
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
  int _activeExerciseId = 0;

  /// Get ID of active exercise
  int get activeExerciseId => _activeExerciseId;

  /// Get state of active exercise
  ExerciseState get activeExercise => _exercises[activeExerciseId];

  /// Update active set and notify any listeners.
  set activeExerciseId(int idx) {
    _activeExerciseId = idx;
    notifyListeners();
  }

  /// Check if current active exercise is the last exercise in the list of
  /// all exercises.
  bool get activeIsLast => activeExerciseId == (exercises.length - 1);

  void addExercise() {
    _exercises.add(ExerciseState());
    notifyListeners();
  }
}
