import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weightlifting.cc/pages/workout.dart';
import 'package:weightlifting.cc/pages/home/login_header.dart';
import 'package:weightlifting.cc/pages/home/workout_list.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: _body(context),
        floatingActionButton: _addButton(context),
      );

  /*
   * Application bar
   *
   */

  Widget _appBar() => AppBar(
        title: Text('weightlifting.cc'),
      );

  /*
   * Main Body
   *
   */

  Widget _body(BuildContext context) => Column(
        children: <Widget>[
          _header(context),
          _workouts(context),
        ],
      );

  Widget _header(BuildContext context) => LoginHeader();

  Widget _workouts(BuildContext context) => ChangeNotifierProvider(
        create: (_) => new Workouts(),
        child: WorkoutList(),
      );

  /*
   * Buttons
   *
   */

  Widget _addButton(BuildContext context) => FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () async {
      final Workout w = await Navigator.push(context, _newWorkoutRoute());
      print('New workout: ' + w.toString());
    }
  );

  Route<Workout> _newWorkoutRoute() => MaterialPageRoute(
    builder: (BuildContext context) => WorkoutPage(locked: false),
  );

}
