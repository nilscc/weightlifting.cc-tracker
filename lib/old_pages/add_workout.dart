import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:weightlifting.cc/json/workout.dart' as JSON;
import 'package:weightlifting.cc/old_pages/exercise_selector.dart' as SELECTOR;
import 'package:weightlifting.cc/old_widgets/date_selector.dart';
import 'package:weightlifting.cc/old_widgets/exercise_tile.dart';
import 'package:weightlifting.cc/old_widgets/new_exercises.dart';
import 'package:provider/provider.dart';

class WorkoutState extends ChangeNotifier {
  JSON.Workout _workout = JSON.Workout(DateTime.now(), "", []);

  int _id = 0;

  JSON.Exercise exercise(final int exerciseIndex) =>
      _workout.exercises[exerciseIndex];

  // Add selected exercise and return exercise index
  int addExercise(final SELECTOR.Exercise e) {
    final int idx = _workout.exercises.length;

    // convert selected exercise to JSON object
    _workout.exercises.add(JSON.Exercise(e.number, e.name, []));

    // notify all listeners about new exercise
    notifyListeners();

    return idx;
  }

  void addSet(final int exerciseIndex, final double weightKG, final int reps) {
    _workout.exercises[exerciseIndex].sets.add(JSON.Set(weightKG, reps));
  }
}

class AddWorkoutPage extends StatelessWidget {
  AddWorkoutPage({Key key}) : super(key: key);

  void save(BuildContext context) {
    // get current list of exercises
    final exercises =
        Provider.of<WorkoutState>(context, listen: false)._workout.exercises;

    // Internal debug prints
    print("Time: " + _dateTime.format());
    print("Exercises: " + exercises.map((e) => e.name).toString());

    // TODO perform save

    // close current page if successful
    Navigator.of(context).pop(context);
  }

  // Main page layout

  Widget title() => Text('Add Workout');

  Widget appBar(context) => AppBar(
        title: title(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => save(context),
          ),
        ],
      );

  // Date + Time selector

  final _dateTime = DateWithOptionalTime();

  Widget dateSelector() => ChangeNotifierProvider.value(
        value: _dateTime,
        child: DateSelectorWidget(),
      );

  // List of new exercises

  Widget exercises(List<JSON.Exercise> exercises) {
    if (exercises.isEmpty)
      return Card(child: Text('No exercises yet.'));
    else
      return Column(
        children:
            exercises.asMap().keys.map((idx) => ExerciseTile(idx)).toList(),
      );
  }

  void _addExercise(BuildContext context, final SELECTOR.Exercise e) {
    Provider.of<WorkoutState>(context, listen: false).addExercise(e);
  }

  // Add exercise button

  Widget addExerciseButton(BuildContext context) => FloatingActionButton(
        onPressed: () async {
          final SELECTOR.Exercise e = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SELECTOR.ExerciseSelectorPage(),
              ));
          print(e);
          if (e != null) _addExercise(context, e);
        },
        child: const Icon(Icons.add),
      );

  // Main build rule

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkoutState>(
      create: (_) => new WorkoutState(),
      builder: (context, child) => Scaffold(
        appBar: appBar(context),
        body: ListView(
          children: <Widget>[
            Card(child: dateSelector()),
            Consumer<WorkoutState>(
              builder: (context, state, child) =>
                  exercises(state._workout.exercises),
            ),
          ],
        ),
        floatingActionButton: addExerciseButton(context),
      ),
    );
  }
}
