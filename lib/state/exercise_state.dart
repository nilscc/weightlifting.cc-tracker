import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/state/set_state.dart';

class ExerciseState extends ChangeNotifier {
  /// Get exercise state of current context (provided via "ChangeNotifierProvider")
  static ExerciseState of(BuildContext context, {bool listen: false}) =>
      Provider.of<ExerciseState>(context, listen: listen);

  /*
   * Internal meta data, e.g. modified status
   *
   */

  bool _isModified = false;

  /// Check if exercise (or any of its sets) has been modified
  bool get isModified => _isModified || _sets.any((set) => set.isModified);

  /// Unset modified state, e.g. after saving exercise (and all of its sets!)
  /// to JSON files.
  void unsetIsModified() {
    _isModified = false;
    _sets.forEach((set) => set.unsetIsModified());
  }

  /*
   * Exercise Details (type, comments, ...)
   *
   */

  int _exerciseId, _previousExerciseId;

  int get exerciseId => _exerciseId;

  set exerciseId(int id) {
    print('set exerciseId = $id');

    if (id != _exerciseId) {
      _exerciseId = id;
      _isModified = true;

      notifyListeners();
    }
  }

  bool get hasExerciseId => _exerciseId != null;

  void unsetExerciseId() {
    if (_exerciseId != null) {
      _previousExerciseId = _exerciseId;
      _exerciseId = null;
      _isModified = true;

      notifyListeners();
    }
  }

  void resetPreviousExerciseId() {
    if (_previousExerciseId != null) {
      _exerciseId = _previousExerciseId;
      _isModified = true;

      notifyListeners();
    }
  }

  /*
   * Set List
   *
   */

  // Set list should by default contain one (the first) set
  final List<SetState> _sets = [SetState(20.0, 1)];

  UnmodifiableListView<SetState> get sets =>
      UnmodifiableListView<SetState>(_sets);

  int _activeSetId = 0;

  int get activeSetId => _activeSetId;

  set activeSetId(int setId) {
    _activeSetId = setId;

    // no need to set to modified for changing sets, but notify listeners
    notifyListeners();
  }

  SetState get activeSet => _sets[_activeSetId];

  void addSet(SetState setState) {
    _sets.add(setState);
    _isModified = true;

    notifyListeners();
  }

  void deleteSet(int setId) {
    assert(0 <= setId && setId < _sets.length);

    _sets.removeAt(setId);

    // check if last element was removed
    if (_sets.isEmpty) {
      _sets.add(SetState(20.0, 1));
      _activeSetId = 0;
    }
    else
      _activeSetId -= 1;

    _isModified = true;

    notifyListeners();
  }
}
