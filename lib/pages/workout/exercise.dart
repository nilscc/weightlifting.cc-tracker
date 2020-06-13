import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/pages/workout/exercise_selector.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';

class ExerciseTitleWidget extends StatelessWidget {
  final BuildContext context;
  final int setIndex;

  ExerciseTitleWidget(this.context, this.setIndex);

  ExerciseState get _state => Provider.of<ExerciseState>(context);

  ExerciseMessages get _exc => ExerciseMessages.of(context);
  WorkoutMessages get _wor => WorkoutMessages.of(context);

  @override
  Widget build(BuildContext context) => Center(child: Row(
        children: [_buildExerciseTitle()] + _buildButtons(),
  ));

  List<Widget> _buildButtons() {
    if (setIndex > 0)
      return [];
    else
      return [];
  }

  Widget _buildExerciseTitle() {
    if (_state.exerciseSet)
      return FlatButton(
        child: Text(_exc.exercise(_state.exerciseId)),
        onPressed: _state.unsetExerciseId,
      );
    else
      return Text(_wor.selectExercise);
  }
}

class ExerciseWidget extends StatelessWidget {
  final BuildContext context;

  ExerciseWidget(this.context);

  ExerciseState get _state => Provider.of<ExerciseState>(context);

  //ExerciseMessages get _exc => ExerciseMessages.of(context);
  //WorkoutMessages get _wor => WorkoutMessages.of(context);

  @override
  Widget build(BuildContext context) {
    if (_state.exerciseSet)
      return _buildSets(context);
    else
      return _buildExerciseSelector(context);
  }

  Widget _buildSets(BuildContext context) => Text('Sets...');

  Widget _buildExerciseSelector(context) => ExerciseSelectorWidget(context);
}
