import 'package:flutter/material.dart';

import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/workout_state.dart';

class ExerciseTitleWidget extends StatefulWidget {
  final int exerciseId;

  ExerciseTitleWidget(this.exerciseId);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ExerciseTitleWidget> {
  @override
  Widget build(BuildContext context) {
    // keep track of most recent exercise ID
    _updateExerciseId();

    return _buildExerciseTitle();
  }

  /// Shared exercise state (read-only)
  ExerciseState get _state => ExerciseState.of(context);

  /// Localization messages
  DialogMessages get _dialogMessages => DialogMessages.of(context);
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

  String get _title =>
      _hasExerciseId ? _exc.exercise(_recentExerciseId) : _wor.selectExercise;

  Widget get _subtitle => _hasExerciseId
      ? Text(_exc.category(_exc.exerciseCategory(_recentExerciseId)))
      : null;

  void _onTap() {
    if (_state.hasExerciseId)
      _state.unsetExerciseId();
    else
      _state.resetPreviousExerciseId();
  }

  void _onLongPress() async {
    final bool discard = await _dialogMessages.showDiscardDialog(context);

    if (discard)
      WorkoutState.of(context).removeExerciseId(this.widget.exerciseId);
  }

  // Build main title
  Widget _buildExerciseTitle() => ListTile(
        title: Text(_title),
        subtitle: _subtitle,
        onTap: _onTap,
        onLongPress: _onLongPress,
      );
}
