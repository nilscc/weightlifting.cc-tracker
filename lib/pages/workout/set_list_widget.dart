import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/pages/workout/set_title_widget.dart';
import 'package:weightlifting.cc/pages/workout/set_widget.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/set_state.dart';

class SetListWidget extends StatelessWidget {
  final BuildContext context;

  SetListWidget(this.context);

  // read-only state access to current exercise
  ExerciseState get _exercise => ExerciseState.of(context);

  // localization messages
  DialogMessages get _dialogMessages => DialogMessages.of(context);
  WorkoutMessages get _workoutMessages => WorkoutMessages.of(context);

  @override
  Widget build(BuildContext context) => Column(
        children: _buildSetList() + [Row(children: _buildSetListControls())],
      );

  List<Widget> _buildSetListControls() => [
        RaisedButton(
          child: Icon(Icons.content_copy),
          onPressed: _copyLastSet,
        ),
        FlatButton(
          child: Text(_workoutMessages.add2_5kg),
          onPressed: () => _copyLastSet(weightIncrement: 2.5),
        ),
        FlatButton(
          child: Text(_workoutMessages.add5kg),
          onPressed: () => _copyLastSet(weightIncrement: 5),
        ),
        FlatButton(
          child: Text(_workoutMessages.add10kg),
          onPressed: () => _copyLastSet(weightIncrement: 10),
        ),
      ];

  void _copyLastSet({double weightIncrement = 0.0, int repIncrement = 0}) {
    // get last element
    final SetState lastSet = _exercise.sets.last;

    // append new set state
    _exercise.addSet(SetState(
        lastSet.weight + weightIncrement, lastSet.reps + repIncrement));

    // set last set as active
    _tapSet(_exercise.sets.length - 1);
  }

  void _deleteSet(int setId) async {
    final bool discard = await _dialogMessages.showDiscardDialog(context);

    if (discard)
      _exercise.deleteSet(setId);
  }

  List<Widget> _buildSetList() => _exercise.sets
      .asMap()
      .map((idx, set) => MapEntry(idx, _buildSet(idx, set)))
      .values
      .toList();

  Widget _buildSet(int index, SetState set) {
    // check if current set is active
    final active = _exercise.activeSetId == index;

    if (active)
      return _activeSet(index, set);
    else
      return _inactiveSet(index, set);
  }

  Widget _activeSet(int index, SetState set) => ListTile(
        onTap: () => _tapSet(index),
        onLongPress: () => _deleteSet(index),
        title: ChangeNotifierProvider.value(
          value: set,
          builder: (context, _) => SetTitleWidget(context),
        ),
        subtitle: ChangeNotifierProvider.value(
          value: set,
          builder: (context, _) => SetWidget(context),
        ),
      );

  Widget _inactiveSet(int index, SetState set) => ListTile(
        onTap: () => _tapSet(index),
        onLongPress: () => _deleteSet(index),
        title: ChangeNotifierProvider.value(
          value: set,
          builder: (context, _) => SetTitleWidget(context),
        ),
      );

  void _setActiveSet(int setIndex) {
    _exercise.activeSetId = setIndex;
  }

  void _tapSet(int setIndex) {
    if (_exercise.activeSetId == setIndex)
      _exercise.activeSetId = null;
    else
      _exercise.activeSetId = setIndex;
  }
}
