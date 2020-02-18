import 'package:flutter/material.dart';
import 'package:flutter_app/change_notifier/new_workout.dart';
import 'package:flutter_app/widgets/date_selector.dart';
import 'package:flutter_app/widgets/exercise_selector.dart';
import 'package:provider/provider.dart';

class AddWorkoutPage extends StatelessWidget {
  AddWorkoutPage({Key key}) : super(key: key);

  final String title = 'Add Workout';

  //final NewWorkout _workout = NewWorkout();

  void save() {
    //_workout.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add workout'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: save,
          ),
        ],
      ),
      body: Card(
        child: ChangeNotifierProvider(
          create: (context) => NewWorkout(),
          child: ListView(
            children: <Widget>[
              DateSelectorWidget(),
              ExerciseSelectorWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
