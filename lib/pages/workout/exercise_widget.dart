import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/pages/workout/exercise_selector_widget.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';

class ExerciseWidget extends StatelessWidget {
  final BuildContext context;

  ExerciseWidget(this.context);

  ExerciseState get _state => Provider.of<ExerciseState>(context);

  @override
  Widget build(BuildContext context) {
    if (_state.hasExerciseId)
      return _buildSets(context);
    else
      return _buildExerciseSelector(context);
  }

  Widget _buildSets(BuildContext context) => Text('Sets...');

  Widget _buildExerciseSelector(context) => ExerciseSelectorWidget(context);
}
