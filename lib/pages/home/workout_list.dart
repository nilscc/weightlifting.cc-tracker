import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/database/storage.dart';

import 'package:weightlifting.cc/json/workout.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/pages/workout.dart';
import 'package:weightlifting.cc/state/database_state.dart';

class Workouts extends ChangeNotifier {
  List<Tuple2<int, Workout>> workouts = [];

  static Workouts of(BuildContext context) =>
      Provider.of<Workouts>(context, listen: false);

  Future<void> load(Database db) async {
    workouts = await allWorkouts(db);

    // done => notify all
    notifyListeners();
  }

//  void delete(final String filePath) async {
//    assert(basename(filePath).startsWith('workout_'));
//    assert(basename(filePath).endsWith('.json'));
//
//    // delete file
//    File(filePath).delete();
//
//    // reload
//    load();
//  }
}

class WorkoutList extends StatelessWidget {
  final BuildContext context;

  WorkoutList(this.context) : assert(context != null);

  DialogMessages get _dialogMessages => DialogMessages.of(context);
  HomeMessages get loc => HomeMessages.of(context);
  ExerciseMessages get _em => ExerciseMessages.of(context);

  Workouts get _state => Provider.of<Workouts>(context, listen: true);
  Workouts get _stateRO => Provider.of<Workouts>(context, listen: false);

  DatabaseState get _databaseState => DatabaseState.of(context);

  @override
  Widget build(BuildContext context) {
    if (_state.workouts.isEmpty)
      return ListTile(
        title: Text(loc.noWorkouts),
      );
    else
      return Column(
        children:
            _state.workouts.map((w) => _workout(w.item1, w.item2)).toList(),
      );
  }

  Widget _workout(final int workoutId, final Workout w) {
    final List<String> exerciseNames =
        w.exercises.map((e) => _em.exercise(e.id)).toList();

    final String date = w.hasTime
        ? DateFormat.yMd().add_jm().format(w.date)
        : DateFormat.yMd().format(w.date);
    final String title = w.title != null ? ' - ${w.title}' : '';

    return ListTile(
      // load workout on tap
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => WorkoutPage(context,
                    locked: false, workout: w, workoutId: workoutId)));
        _stateRO.load(await _databaseState.database);
      },

      // delete workout on long press
      onLongPress: () async {
        final bool discard = await _dialogMessages.showDiscardDialog(context);
        //if (discard) _stateRO.delete(filePath);
      },

      // layout
      leading: Icon(
        Icons.check,
        color: Colors.green,
      ),
      title: Text('$date$title'),
      subtitle: Text('${exerciseNames.join("\n")}'),
    );
  }
}
