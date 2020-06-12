import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/localization/messages.dart';

import 'package:weightlifting.cc/pages/workout/exercises.dart';
import 'package:weightlifting.cc/pages/workout/save_button.dart';
import 'package:weightlifting.cc/pages/workout/workout_details.dart';

class WorkoutPage extends StatelessWidget {
  final BuildContext context;

  final bool locked;

  // Change notifiers
  final WorkoutDetails _details = WorkoutDetails();
  final ExercisesState _exercises = ExercisesState();

  WorkoutPage(this.context, {this.locked: true});

  // localization
  DialogMessages get _dia => DialogMessages.of(context);
  WorkoutMessages get loc => WorkoutMessages.of(context);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(context),
        body: _body(context),
      );

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
      return await _dia.showDiscardDialog(context);
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
              builder: (BuildContext context, _) => ExercisesWidget(context),
            ),
          ),
        ],
      ),
    );
  }
}
