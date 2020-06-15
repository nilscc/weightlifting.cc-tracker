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
  //ExerciseMessages get _exerciseMessages => ExerciseMessages.of(context);

  @override
  Widget build(BuildContext context) => Column(
        children: _exercise.sets
            .asMap()
            .map((idx, set) => MapEntry(idx, _buildSet(idx, set)))
            .values
            .toList(),
      );

  Widget _buildSet(int index, SetState set) {
    // check if current set is active
    final active = _exercise.activeSetId == index;

    print('Set #$index: active=$active');

    if (active)
      return _activeSet(index, set);
    else
      return _inactiveSet(index, set);
  }

  Widget _activeSet(int index, SetState set) => ListTile(
        onTap: () => _tapSet(index),
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
        title: ChangeNotifierProvider.value(
          value: set,
          builder: (context, _) => SetTitleWidget(context),
        ),
      );

  void _tapSet(int setIndex) {
    _exercise.activeSetId = setIndex;
  }
}
