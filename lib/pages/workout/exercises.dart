import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/pages/workout/exercise.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/workout_state.dart';

class ExercisesWidget extends StatelessWidget {
  final BuildContext context;

  ExercisesWidget(this.context);

  WorkoutMessages get loc => WorkoutMessages.of(context);
  DialogMessages get _dia => DialogMessages.of(context);

  @override
  Widget build(BuildContext context) => Stepper(
        physics: NeverScrollableScrollPhysics(),
        steps: WorkoutState.of(context)
            .exercises
            .asMap()
            .map((i, e) => MapEntry(i, _renderExercise(i, e)))
            .values
            .toList(),
        onStepCancel: _discardActiveSet,
      );

  void _discardActiveSet() async {
    final bool discard = await _dia.showDiscardDialog(context);

    print('Discard active set = $discard');

    // TODO: remove active set, close workout if last?
  }

  Step _renderExercise(int index, ExerciseState e) => Step(
        title: ChangeNotifierProvider.value(
          value: e,
          builder: (context, _) => ExerciseTitleWidget(context, index),
        ),
        content: ChangeNotifierProvider.value(
          value: e,
          builder: (context, _) => Padding(
            padding: EdgeInsets.all(1.0),
            child: ExerciseWidget(context),
          ),
        ),
        isActive: WorkoutState.of(context).activeSet == index,
      );
}
