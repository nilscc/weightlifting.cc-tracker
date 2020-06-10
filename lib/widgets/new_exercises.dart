import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/new_exercise.dart';
import 'package:provider/provider.dart';

class NewExercises extends ChangeNotifier {
  final List<NewExercise> _exercises = [];

  int length() => _exercises.length;

  UnmodifiableListView<NewExercise> exercises() =>
      UnmodifiableListView(_exercises);
}

class NewExercisesWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewExercisesState();
}

class _NewExercisesState extends State<NewExercisesWidget> {

  List<bool> _expanded = [];

  List<ExpansionPanel> exercises(final NewExercises exercises) {
    return exercises
        .exercises()
        .asMap()
        .map((index, e) => MapEntry(
            index,
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: _expanded[index],
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(title: Text(e.name()));
              },
              body: Text('moep'),
            )))
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) => Consumer<NewExercises>(
        builder: (context, newExercises, child) {
          return ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              if (index < _expanded.length)
                setState(() {
                  _expanded[index] = !isExpanded;
                });
            },
            children: exercises(newExercises),
          );
        },
      );
}