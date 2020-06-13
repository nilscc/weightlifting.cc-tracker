import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/localization/messages.dart';

import 'package:weightlifting.cc/pages/workout/exercises_widget.dart';
import 'package:weightlifting.cc/pages/workout/save_button_widget.dart';
import 'package:weightlifting.cc/pages/workout/workout_details_widget.dart';
import 'package:weightlifting.cc/state/workout_state.dart';

class WorkoutPage extends StatelessWidget {
  final BuildContext context;

  final bool locked;

  WorkoutPage(this.context, {this.locked: true});

  // state
  final WorkoutState _workout = WorkoutState();

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
          value: _workout,
          builder: (context, _) => SaveButtonWidget(context),
        ),
      ];
  }

  /*
   * Body
   *
   */

  Future<bool> _canPop(BuildContext context) async {
    if (_workout.isModified)
      return await _dia.showDiscardDialog(context);
    else
      return true;
  }

  Widget _body(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _canPop(context),
      child: ChangeNotifierProvider.value(
        value: _workout,
        builder: (context, _) => ListView(
          children: <Widget>[
            Card(child: WorkoutDetailsWidget()),
            Card(child: ExercisesWidget(context)),
          ],
        ),
      ),
    );
  }
}
