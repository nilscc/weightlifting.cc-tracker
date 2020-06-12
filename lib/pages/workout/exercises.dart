import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/pages/workout/exercise.dart';

class ExercisesState extends ChangeNotifier {
  bool _isModified = false;
  bool get isModified => _isModified || _exercises.any((exc) => exc.isModified);
  void unsetIsModified() {
    _isModified = false;
    _exercises.forEach((e) => e.unsetIsModified());
  }

  int get count => 0;

  final List<ExerciseState> _exercises = [ExerciseState()];

  UnmodifiableListView<ExerciseState> get exercises =>
      UnmodifiableListView(_exercises);

  void addExercise() {
    _exercises.add(ExerciseState());
    _isModified = true;
    notifyListeners();
  }

  int _activeSet = 0;
  int get activeSet => _activeSet;
  set activeSet(int idx) {
    _activeSet = idx;
    notifyListeners();
  }
}

class ExercisesWidget extends StatelessWidget {
  final BuildContext context;

  ExercisesWidget(this.context);

  WorkoutMessages get loc => WorkoutMessages.of(context);
  DialogMessages get _dia => DialogMessages.of(context);

  ExercisesState get _state =>
      Provider.of<ExercisesState>(context, listen: false);

  @override
  Widget build(BuildContext context) => Stepper(
        physics: NeverScrollableScrollPhysics(),
        steps: _state.exercises
            .asMap()
            .map((i, e) => MapEntry(i, _renderExercise(i, e)))
            .values
            .toList(),
        onStepCancel: _discardActiveSet,
      );

  void _discardActiveSet() async {
    final bool discard = await _dia.showDiscardDialog(context);

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
        isActive: _state.activeSet == index,
      );
}
