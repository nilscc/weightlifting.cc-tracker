import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weightlifting.cc/database/types.dart' as dbt;
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
   * File storage data
   *
   */

  int _databaseId;
  int get databaseId => _databaseId;

  Future<void> save(Database db, final int exerciseId) async {
    final set = dbt.Set(
      id: databaseId,
      workoutExerciseId: exerciseId,
      sets: sets,
      reps: reps,
      weight: weight,
    );

    if (set.id != null)
      set.update(db);
    else
      _databaseId = await set.insert(db);
  }

  static Future<List<SetState>> queryByExerciseId(
      BuildContext context, Database db, final int exerciseId) async {
    List<SetState> sets = [];

    for (final s in await dbt.Set.queryByExerciseId(db, exerciseId)) {
      SetState setState = SetState(context, 0.0, 0);

      setState._databaseId = s.id;
      setState._sets = s.sets;
      setState._reps = s.reps;
      setState._weight = s.weight;

      sets.add(setState);
    }

    return sets;
  }

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
    assert(weight >= 0.0);

    if (_weight != weight) {
      _weight = weight;
      _modified = true;

      notifyListeners();
    }
  }

  int _reps = 0;
  int get reps => _reps;

  set reps(int reps) {
    assert(reps >= 0);

    if (_reps != reps) {
      _reps = reps;
      _modified = true;

      notifyListeners();
    }
  }

  void incrementReps() => reps += 1;
  void decrementReps() => reps = max(0, reps - 1);

  int _sets = 1;
  int get sets => _sets;
  set sets(int sets) {
    assert(sets >= 1);

    if (_sets != sets) {
      _sets = sets;
      _modified = true;

      notifyListeners();
    }
  }
}
