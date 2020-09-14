import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/json/workout.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/pages/home/sync_widget.dart';

import 'package:weightlifting.cc/pages/workout.dart';
import 'package:weightlifting.cc/pages/home/login_header.dart';
import 'package:weightlifting.cc/pages/home/workout_list.dart';
import 'package:weightlifting.cc/state/database_state.dart';

class HomePage extends StatelessWidget {

  final BuildContext context;

  HomePage(this.context);

  // Localization messages
  HomeMessages get _homeMessages => HomeMessages.of(context);

  // States
  DatabaseState get _database => DatabaseState.of(context);

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

  Widget _body(BuildContext context) => ListView(
        children: <Widget>[
          _header(context),
          ChangeNotifierProvider.value(
            value: _workouts,
            builder: (context, _) => SyncWidget(context),
          ),
          FutureBuilder(
            future: _buildWorkouts(context),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return snapshot.data;
              else
                return _loadingWorkouts();
            },
          ),
        ],
      );

  Widget _header(BuildContext context) => LoginHeader(context);

  Widget _loadingWorkouts() => Text(_homeMessages.loadingWorkouts);

  final Workouts _workouts = Workouts();

  Future<Widget> _buildWorkouts(BuildContext context) async {
    await _workouts.load(await _database.database);

    return ChangeNotifierProvider.value(
      value: _workouts,
      builder: (BuildContext context, _) => WorkoutList(context),
    );
  }

  /*
   * Buttons
   *
   */

  Widget _addButton(BuildContext context) => FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        await Navigator.push(context, _newWorkoutRoute());
        _workouts.load(await _database.database);
      });

  Route<Workout> _newWorkoutRoute() => MaterialPageRoute(
        builder: (BuildContext context) => WorkoutPage(context, locked: false),
      );
}
