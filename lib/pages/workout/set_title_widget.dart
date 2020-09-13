import 'package:flutter/material.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/set_state.dart';
import 'package:weightlifting.cc/state/workout_state.dart';

class SetTitleWidget extends StatelessWidget {
  final BuildContext context;

  // states
  WorkoutState get _workout => WorkoutState.of(context);
  ExerciseState get _exercise => ExerciseState.of(context);

  // localization messages
  DialogMessages get _dialogMessages => DialogMessages.of(context);

  final int index;

  bool get active => _exercise.activeSetId == index;

  SetTitleWidget(this.context, this.index);

  // read-only access to set state
  SetState get _state => SetState.of(context, listen: true);

  @override
  Widget build(BuildContext context) => FlatButton(
        onPressed: () => _toggleActive(),
        onLongPress: () => _deleteSet(),
        color: active ? Colors.grey : null,
        child: Container(
          child: Column(
            children: <Widget>[
              Text(_state.weight.toStringAsFixed(1)),
              Divider(
                height: 4,
                color: Colors.black,
              ),
              Text(_state.reps.toString()),
            ],
          ),
          width: 50,
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        ),
      );

  void _toggleActive() {
    _exercise.activeSetId = _exercise.activeSetId == index ? null : index;
    _workout.activeExerciseId = _workout.exercises.indexOf(_exercise);
  }

  void _deleteSet() async {
    final bool discard = await _dialogMessages.showDiscardDialog(context);
    if (discard) _exercise.deleteSet(index);
  }
}
