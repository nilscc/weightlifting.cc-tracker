import 'package:flutter/material.dart';
import 'package:flutter_app/pages/exercise_selector.dart';
import 'package:flutter_app/widgets/date_selector.dart';
import 'package:flutter_app/widgets/new_exercises.dart';
import 'package:provider/provider.dart';

class AddWorkoutPage extends StatelessWidget {
  AddWorkoutPage({Key key}) : super(key: key);

  void save(BuildContext context) {
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

  Widget dateSelector() => ChangeNotifierProvider(
        create: (context) => _dateTime,
        child: DateSelectorWidget(),
      );

  // List of new exercises

  final List<Exercise> _newExercises = [];

  Widget newExercises() {
    if (_newExercises.length == 0)
      return Card(child: Text('No exercises yet.'));
    else
      return ListView(children: _newExercises.map((e) =>
          Text(e.name)).toList()
      );
  }

  void _addExercise(BuildContext context, final Exercise e) {
    print('${e.name} added');
  }

  // Add exercise button

  Widget addExerciseButton(BuildContext context) => FloatingActionButton(
        onPressed: () async {
          final Exercise e = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseSelectorPage(),
              ));
          print(e);
          if (e != null) _addExercise(context, e);
        },
        child: const Icon(Icons.add),
      );

  // Main build rule

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: <Widget>[
          Card(child: dateSelector()),
          newExercises(),
        ],
      ),
      floatingActionButton: addExerciseButton(context),
    );
  }
}
