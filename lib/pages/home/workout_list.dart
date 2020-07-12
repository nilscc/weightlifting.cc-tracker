import 'dart:convert';
import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:weightlifting.cc/json/workout.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/pages/workout.dart';

class Workouts extends ChangeNotifier {
  final List<Tuple2<String, Workout>> workouts = [];

  Future<void> load() async {
    // make sure list is empty
    workouts.clear();

    // search app directory for workout files
    Directory appDir = await getApplicationDocumentsDirectory();

    final lis = appDir.listSync();
    for (FileSystemEntity path in lis) {
      if (path is File) {
        final File f = path;

        final String base = basename(f.path);
        print(base);

        if (base.startsWith('workout_') && base.endsWith('.json')) {
          final String content = await f.readAsString();
          final Map x = jsonDecode(content);
          final Workout json = Workout.fromJson(x);

          workouts.add(Tuple2(f.path, json));
        }
      }
    }

    // sort by date (reversed)
    workouts.sort((a, b) => b.item2.date.compareTo(a.item2.date));

    // done => notify all
    notifyListeners();
  }

  void delete(final String filePath) async {
    assert(basename(filePath).startsWith('workout_'));
    assert(basename(filePath).endsWith('.json'));

    // delete file
    File(filePath).delete();

    // reload
    load();
  }
}

class WorkoutList extends StatelessWidget {
  final BuildContext context;

  WorkoutList(this.context) : assert(context != null);

  DialogMessages get _dialogMessages => DialogMessages.of(context);
  HomeMessages get loc => HomeMessages.of(context);
  ExerciseMessages get _em => ExerciseMessages.of(context);

  Workouts get _state => Provider.of<Workouts>(context, listen: true);
  Workouts get _stateRO => Provider.of<Workouts>(context, listen: false);

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

  Widget _workout(final String filePath, final Workout w) {
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
                    locked: false, workout: w, filePath: filePath)));
        _stateRO.load();
      },

      // delete workout on long press
      onLongPress: () async {
        final bool discard = await _dialogMessages.showDiscardDialog(context);
        if (discard) _stateRO.delete(filePath);
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
