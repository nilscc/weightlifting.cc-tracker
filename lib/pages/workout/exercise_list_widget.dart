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
  WorkoutMessages get _workoutMessages => WorkoutMessages.of(context);

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
                    child: Text(_workoutMessages.addExercise),
                    onPressed: _addExercise,
                  )
                ],
              )
            ],
      );

  void _addExercise() {
    _workout.addExercise();
  }

  Widget _renderExercise(int index, ExerciseState e) =>
      ChangeNotifierProvider.value(
        value: e,
        builder: (context, _) => Card(
          child: Column(
            children: <Widget>[
              ExerciseTitleWidget(index),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: ExerciseWidget(context),
              ),
            ],
          ),
        ),
      );
}
