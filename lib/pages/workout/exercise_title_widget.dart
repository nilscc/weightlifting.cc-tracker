import 'package:flutter/material.dart';

import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';

class ExerciseTitleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ExerciseTitleWidget> {
  @override
  Widget build(BuildContext context) {

    // keep track of most recent exercise ID
    _updateExerciseId();

    return Center(
        child: Row(
      children: [_buildExerciseTitle()],
    ));
  }

  /// Shared exercise state (read-only)
  ExerciseState get _state => ExerciseState.of(context);

  /// Localization messages
  WorkoutMessages get _wor => WorkoutMessages.of(context);
  ExerciseMessages get _exc => ExerciseMessages.of(context);

  int _recentExerciseId;

  bool get _hasExerciseId => _recentExerciseId != null;

  void _updateExerciseId() {
    final state = ExerciseState.of(context, listen: true);

    if (state.hasExerciseId && state.exerciseId != _recentExerciseId) {
      setState(() {
        _recentExerciseId = state.exerciseId;
      });
    }
  }

  // Build main title
  Widget _buildExerciseTitle() {
    if (_hasExerciseId)
      return FlatButton(
        child: Text(_exc.exercise(_recentExerciseId)),
        onPressed: _state.unsetExerciseId,
      );
    else
      return Text(_wor.selectExercise);
  }
}
