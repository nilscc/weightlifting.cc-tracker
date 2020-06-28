import 'package:flutter/material.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';

class ExerciseSelectorWidget extends StatefulWidget {
  final BuildContext context;
  ExerciseSelectorWidget(this.context);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ExerciseSelectorWidget> {
  ExerciseMessages get _exc => ExerciseMessages.of(context);

  int _expanded;

  ExerciseState get _exerciseState => ExerciseState.of(context);

  @override
  Widget build(BuildContext context) => _buildCategories(context);

  Widget _buildCategories(BuildContext context) => ExpansionPanelList(
        expansionCallback: (idx, isExpanded) {
          setState(() {
            if (_expanded == idx && isExpanded)
              _expanded = null;
            else
              _expanded = idx;
          });
        },
        children: _exc.categoryIds
            .asMap()
            .map((idx, cid) => MapEntry(idx, _buildCategory(context, idx, cid)))
            .values
            .toList(),
      );

  ExpansionPanel _buildCategory(
          BuildContext context, int index, int categoryId) =>
      ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (context, isExpanded) =>
            ListTile(title: Text(_exc.category(categoryId))),
        isExpanded: _expanded == index,
        body: Column(
          children: _exc.categoryExercises(categoryId).map((exerciseId) => _buildExercise(exerciseId)).toList(),
        ),
      );

  Widget _buildExercise(int exerciseId) => FlatButton(
    child: Text(_exc.exercise(exerciseId)),
    onPressed: () => _exerciseState.exerciseId = exerciseId,
  );
}
