import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/json/workout.dart' as json;

class SetState extends ChangeNotifier {

  SetState(this._weight, this._reps);

  SetState.read(final json.Set set)
    : _reps = set.repetitions
    , _weight = set.weightKg;

  /// Static provider method
  static SetState of(BuildContext context, {bool listen: false}) =>
      Provider.of<SetState>(context, listen: listen);

  /*
   * Modified status
   *
   */

  bool _isModified = false;

  /// Get current modified status
  bool get isModified => _isModified;

  void unsetIsModified() => _isModified = false;

  /*
   * Set details (weight, reps...)
   *
   */

  double _weight = 0.0;

  double get weight => _weight;

  set weight(double weight) {
    assert(weight >= 0);

    _weight = weight;
    _isModified = true;

    notifyListeners();
  }

  int _reps = 0;

  int get reps => _reps;

  set reps(int reps) {
    assert(reps >= 0);

    _reps = reps;
    _isModified = true;

    notifyListeners();
  }

  void incrementReps() => reps += 1;
  void decrementReps() => reps = max(0, reps - 1);

}
