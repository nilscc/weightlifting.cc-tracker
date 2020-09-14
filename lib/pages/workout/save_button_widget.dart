import 'package:flutter/material.dart';
import 'package:weightlifting.cc/state/database_state.dart';
import 'package:weightlifting.cc/state/modified_state.dart';

import 'package:weightlifting.cc/state/workout_state.dart';

class SaveButtonWidget extends StatelessWidget {
  final BuildContext context;

  SaveButtonWidget(this.context);

  // Change notifier getters
  DatabaseState get _databaseState => DatabaseState.of(context);
  ModifiedState get _modifiedState => ModifiedState.of(context);
  WorkoutState get workout => WorkoutState.of(context);

  void _save() async {
    await workout.save(await _databaseState.database);
    _modifiedState.modified = false;
  }

  @override
  Widget build(BuildContext context) => FlatButton(
        child: Icon(
          Icons.save,
          color: ModifiedState.of(context, listen: true).modified
              ? Colors.white70
              : Theme.of(context).disabledColor,
        ),
        onPressed: _save,
      );
}
