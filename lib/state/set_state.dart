import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/json/workout.dart' as json;
import 'package:weightlifting.cc/state/modified_state.dart';

class SetState extends ChangeNotifier {

  final BuildContext context;

  SetState(this.context, this._weight, this._reps);

  SetState.read(this.context, final json.Set set)
    : _reps = set.repetitions
    , _weight = set.weightKg;

  /// Static provider method
  static SetState of(BuildContext context, {bool listen: false}) =>
      Provider.of<SetState>(context, listen: listen);

  /*
   * Modified state
   *
   */

  ModifiedState get _modifiedState => ModifiedState.of(context);

  set _modified(final bool newValue) => _modifiedState.modified = newValue;

  /*
   * Set details (weight, reps...)
   *
   */

  double _weight = 0.0;

  double get weight => _weight;

  set weight(double weight) {
    assert(weight >= 0);

    _weight = weight;
    _modified = true;

    notifyListeners();
  }

  int _reps = 0;

  int get reps => _reps;

  set reps(int reps) {
    assert(reps >= 0);

    _reps = reps;
    _modified = true;

    notifyListeners();
  }

  void incrementReps() => reps += 1;
  void decrementReps() => reps = max(0, reps - 1);

}
