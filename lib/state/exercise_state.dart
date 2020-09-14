import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/json/workout.dart';
import 'package:weightlifting.cc/state/modified_state.dart';
import 'package:weightlifting.cc/state/set_state.dart';

class ExerciseState extends ChangeNotifier {
  final BuildContext context;

  ExerciseState(this.context) : _sets = [SetState(context, 20.0, 1)];

  ExerciseState.read(this.context, final Exercise exercise)
      : _exerciseId = exercise.id,
        _activeSetId = null,
        _sets = exercise.sets.map((s) => SetState.read(context, s)).toList();

  /// Get exercise state of current context (provided via "ChangeNotifierProvider")
  static ExerciseState of(BuildContext context, {bool listen: false}) =>
      Provider.of<ExerciseState>(context, listen: listen);

  /*
   * Modified state
   *
   */

  ModifiedState get _modifiedState => ModifiedState.of(context);

  set _modified(final bool newValue) => _modifiedState.modified = newValue;

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
      _modified = true;

      notifyListeners();
    }
  }

  bool get hasExerciseId => _exerciseId != null;

  void unsetExerciseId() {
    if (_exerciseId != null) {
      _previousExerciseId = _exerciseId;
      _exerciseId = null;
      _modified = true;

      notifyListeners();
    }
  }

  void resetPreviousExerciseId() {
    if (_previousExerciseId != null) {
      _exerciseId = _previousExerciseId;
      _modified = true;

      notifyListeners();
    }
  }

  /*
   * Set List
   *
   */

  // Set list should by default contain one (the first) set
  final List<SetState> _sets;

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
    if (activeSetId != null)
      _sets.insert(activeSetId + 1, setState);
    else
      _sets.add(setState);

    _modified = true;

    notifyListeners();
  }

  void deleteSet(int setId) {
    assert(0 <= setId && setId < _sets.length);

    _sets.removeAt(setId);

    // check if last element was removed
    if (_sets.isEmpty) {
      _sets.add(SetState(context, 20.0, 1));
      _activeSetId = 0;
    } else if (_activeSetId != null) {
      if (_activeSetId == setId)
        _activeSetId = null;
      else if (_activeSetId > setId) _activeSetId--;
    }

    _modified = true;

    notifyListeners();
  }
}
