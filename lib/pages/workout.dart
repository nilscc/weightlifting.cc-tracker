import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/json/workout.dart';
import 'package:weightlifting.cc/localization/messages.dart';

import 'package:weightlifting.cc/pages/workout/exercise_list_widget.dart';
import 'package:weightlifting.cc/pages/workout/save_button_widget.dart';
import 'package:weightlifting.cc/pages/workout/workout_details_widget.dart';
import 'package:weightlifting.cc/state/modified_state.dart';
import 'package:weightlifting.cc/state/workout_state.dart';

class WorkoutPage extends StatelessWidget {
  final BuildContext context;

  final bool locked;

  final String filePath;
  final Workout workout;

  WorkoutPage(this.context, {this.locked: true, this.filePath, this.workout});

  // localization
  DialogMessages get _dia => DialogMessages.of(context);
  WorkoutMessages get loc => WorkoutMessages.of(context);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => ModifiedState(),
        builder: (context, _) => ChangeNotifierProvider(
          create: (_) {
            if (filePath != null && workout != null)
              return WorkoutState.read(context, filePath, workout);
            else
              return WorkoutState(context);
          },
          builder: (context, _) => Scaffold(
            appBar: _appBar(context),
            body: _body(context),
          ),
        ),
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
      return [SaveButtonWidget(context)];
  }

  /*
   * Body
   *
   */

  bool _modified(BuildContext context) => ModifiedState.of(context).modified;

  Future<bool> _canPop(BuildContext context) async {
    if (_modified(context))
      return await _dia.showDiscardDialog(context);
    else
      return true;
  }

  Widget _body(BuildContext context) => WillPopScope(
        onWillPop: () => _canPop(context),
        child: ListView(
          children: <Widget>[
            WorkoutDetailsWidget(context),
            ExerciseListWidget(context),
          ],
        ),
      );
}
