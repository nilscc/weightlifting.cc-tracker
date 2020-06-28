import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/json/workout.dart';
import 'package:weightlifting.cc/localization/messages.dart';

class Workouts extends ChangeNotifier {
  final List<Workout> workouts = [];

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

          workouts.add(json);
        }
      }
    }

    // sort by date (reversed)
    workouts.sort((a,b) => b.date.compareTo(a.date));

    // done => notify all
    notifyListeners();
  }
}

class WorkoutList extends StatelessWidget {
  final BuildContext context;

  WorkoutList(this.context) : assert(context != null);

  HomeMessages get loc => HomeMessages.of(context);
  ExerciseMessages get _em => ExerciseMessages.of(context);

  Workouts get _state => Provider.of<Workouts>(context, listen: true);

  @override
  Widget build(BuildContext context) {
    if (_state.workouts.isEmpty)
      return ListTile(
        title: Text(loc.noWorkouts),
      );
    else
      return Column(
        children: _state.workouts.map((w) => _workout(w)).toList(),
      );
  }

  Widget _workout(Workout w) {

    final List<String> exerciseNames = w.exercises.map((e) => _em.exercise(e.id)).toList();

    final String date = w.hasTime ? DateFormat.yMd().add_jm().format(w.date) : DateFormat.yMd().format(w.date);
    final String title = w.title != null ? ' - ${w.title}' : '';

    return ListTile(
      onTap: () {},
      leading: Icon(Icons.check, color: Colors.green,),
      title: Text('$date$title'),
      subtitle: Text(
          '${exerciseNames.join("\n")}'),
    );
  }
}
