import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/pages/workout/exercise_title_widget.dart';
import 'package:weightlifting.cc/pages/workout/exercise_widget.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/workout_state.dart';

class ExerciseListWidget extends StatelessWidget {
  final BuildContext context;

  ExerciseListWidget(this.context);

  // read-only state reference
  WorkoutState get _workout => WorkoutState.of(context);

  // localization messages
  WorkoutMessages get loc => WorkoutMessages.of(context);
  DialogMessages get _dia => DialogMessages.of(context);

  @override
  Widget build(BuildContext context) => Column(
        children: WorkoutState.of(context, listen: true)
                .exercises
                .asMap()
                .map((i, e) => MapEntry(i, _renderExercise(i, e)))
                .values
                .toList() +
            [
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text(loc.addExercise),
                    onPressed: _stepContinue,
                  )
                ],
              )
            ],
      );

  void _stepContinue() {
    _workout.addExercise();
  }

  void _stepCancel() async {
    // get exercise of current step
    final ExerciseState exercise = _workout.activeExercise;

    // figure out in which part of the step we are

    // check, if we are in exercise selection mode (exercise ID is not set)
    if (!exercise.hasExerciseId)
      exercise.resetPreviousExerciseId();
    else
      _discardActiveExercise();
  }

  void _discardActiveExercise() async {
    final bool discard = await _dia.showDiscardDialog(context);

    print('Discard active exercise = $discard');

    // TODO: remove active exercise
  }

  Widget _renderExercise(int index, ExerciseState e) =>
      ChangeNotifierProvider.value(
        value: e,
        builder: (context, _) => Card(
          child: Column(
            children: <Widget>[
              ExerciseTitleWidget(),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: ExerciseWidget(context),
              ),
            ],
          ),
        ),
      );
}
