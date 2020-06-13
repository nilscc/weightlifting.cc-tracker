import 'package:flutter/material.dart';

import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';

class ExerciseTitleWidget extends StatelessWidget {

  final BuildContext context;
  final int setIndex;

  ExerciseTitleWidget(this.context, this.setIndex);

  @override
  Widget build(BuildContext context) => Center(child: Row(
    children: [_buildExerciseTitle()] + _buildButtons(),
  ));

  /// Shared exercise state
  ExerciseState get _state => ExerciseState.of(context);

  /// Localization messages
  WorkoutMessages get _wor => WorkoutMessages.of(context);
  ExerciseMessages get _exc => ExerciseMessages.of(context);

  // Build buttons
  List<Widget> _buildButtons() {
    if (setIndex > 0)
      return []; // TODO
    else
      return []; // TODO
  }

  // Build main title
  Widget _buildExerciseTitle() {
    if (_state.hasExerciseId)
      return FlatButton(
        child: Text(_exc.exercise(_state.exerciseId)),
        onPressed: _state.unsetExerciseId,
      );
    else
      return Text(_wor.selectExercise);
  }
}