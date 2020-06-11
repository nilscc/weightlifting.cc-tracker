import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/json/workout.dart';

import 'package:weightlifting.cc/localization/de.dart';
import 'package:weightlifting.cc/pages/workout/exercises.dart';
import 'package:weightlifting.cc/pages/workout/save_button.dart';
import 'package:weightlifting.cc/pages/workout/workout_details.dart';

class WorkoutPage extends StatelessWidget {
  final bool locked;

  // Change notifiers
  final WorkoutDetails _details = WorkoutDetails();
  final Exercises _exercises = Exercises();

  WorkoutPage({this.locked: true});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(context),
        body: _body(context),
      );

  void _save(BuildContext context) {
    // should only be called when workout is not locked anyway
    assert(!locked);

    if (_details.dateTime != null && _details.title != null)
      print(
          'Save: [${_details.dateTime.toIso8601String()}] "${_details.title}"');
    else
      print(
          'Invalid workout: Missing date (${_details.dateTime}) and/or title (${_details.title})');
  }

  /*
   * Application Bar
   *
   */

  Widget _appBar(BuildContext context) => AppBar(
        title: Text('Workout'),
        actions: _actions(context),
      );

  List<Widget> _actions(BuildContext context) {
    if (locked)
      return [];
    else
      return [
        ChangeNotifierProvider.value(
          value: _details,
          child: ChangeNotifierProvider.value(
            value: _exercises,
            builder: (context, _) => SaveButton(context),
          ),
        ),
      ];
  }

  /*
   * Body
   *
   */

  bool get _isModified => _details.isModified || _exercises.isModified;

  Future<bool> _canPop(BuildContext context) async {
    if (_isModified)
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(DIALOG_DISCARD_TITLE),
          content: Text(DIALOG_DISCARD_CONTENT),
          actions: <Widget>[
            FlatButton(
              child: Text(DIALOG_DISCARD_BUTTON_DISCARD),
              onPressed: () => Navigator.pop(context, true),
            ),
            RaisedButton(
              child: Text(DIALOG_DISCARD_BUTTON_BACK),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      );
    else
      return true;
  }

  Widget _body(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _canPop(context),
      child: ListView(
        children: <Widget>[
          Card(
            child: ChangeNotifierProvider.value(
              value: _details,
              child: WorkoutDetailsWidget(),
            ),
          ),
          Card(
            child: ChangeNotifierProvider.value(
              value: _exercises,
              child: ExercisesWidget(),
            ),
          ),
        ],
      ),
    );
  }
}