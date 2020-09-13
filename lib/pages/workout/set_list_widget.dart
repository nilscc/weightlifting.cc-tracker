import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/pages/workout/set_controls_widget.dart';
import 'package:weightlifting.cc/pages/workout/set_title_widget.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/set_state.dart';

class SetListWidget extends StatelessWidget {
  final BuildContext context;

  SetListWidget(this.context);

  // read-only state access to current exercise
  ExerciseState get _exercise => ExerciseState.of(context);

  int get _preLength => _exercise.activeSetId == null
      ? _exercise.sets.length
      : _exercise.activeSetId + 1;

  Iterable<SetState> _preSets() => _exercise.sets.getRange(0, _preLength);

  Iterable<SetState> _postSets() =>
      _exercise.sets.getRange(_preLength, _exercise.sets.length);

  @override
  Widget build(BuildContext context) => Column(
        children: [_buildSets(_preSets())] +
            _controls() +
            [_buildSets(_postSets(), indexOffset: _preLength)],
      );

  List<Widget> _controls() {
    if (_exercise.activeSetId == null)
      return [];
    else
      return [
        ChangeNotifierProvider.value(
          value: _exercise.sets[_exercise.activeSetId],
          builder: (context, _) => SetControlsWidget(context),
        ),
      ];
  }

  Widget _buildSets(Iterable<SetState> setList, {int indexOffset: 0}) => Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          children: _buildSetsList(setList, indexOffset),
          direction: Axis.horizontal,
          runSpacing: 15,
          alignment: WrapAlignment.start,
        ),
      );

  List<Widget> _buildSetsList(Iterable<SetState> setList, int indexOffset) =>
      setList
          .toList()
          .asMap()
          .map((idx, set) => MapEntry(
              idx,
              ChangeNotifierProvider.value(
                value: set,
                builder: (context, _) =>
                    SetTitleWidget(context, indexOffset + idx),
              )))
          .values
          .toList();
}
