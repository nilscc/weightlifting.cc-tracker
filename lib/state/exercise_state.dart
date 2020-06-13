import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/state/set_state.dart';

class ExerciseState extends ChangeNotifier {

  /// Get exercise state of current context (provided via "ChangeNotifierProvider")
  static ExerciseState of(BuildContext context, {bool listen: false}) =>
      Provider.of<ExerciseState>(context, listen: listen);

  bool get isEmpty => !(hasExerciseId && hasSets);

  /*
   * Internal meta data, e.g. modified status
   *
   */

  bool _isModified = false;
  bool get isModified => _isModified;
  void unsetIsModified() => _isModified = false;


  /*
   * Exercise Details (type, comments, ...)
   *
   */

  int _exerciseId, _previousExerciseId;
  int get exerciseId => _exerciseId;

  set exerciseId(int id) {
    _exerciseId = id;
    _isModified = true;
    notifyListeners();
  }

  bool get hasExerciseId => _exerciseId != null;

  void unsetExerciseId() {
    _previousExerciseId = _exerciseId;
    _exerciseId = null;
    _isModified = true;
    notifyListeners();
  }

  void resetPreviousExerciseId() {
    _exerciseId = _previousExerciseId;
    _isModified = true;
    notifyListeners();
  }

  /*
   * Set List
   *
   */

  final List<SetState> _sets = [];

  bool get hasSets => _sets.isEmpty;
}
