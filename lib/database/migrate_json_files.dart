import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weightlifting.cc/database/types.dart' as dbt;
import 'package:weightlifting.cc/json/workout.dart' as json;

Future<bool> migrateJsonFiles(Database db) async {
  bool foundNewFiles = false;

  // search app directory for workout files
  Directory appDir = await getApplicationDocumentsDirectory();

  final lis = appDir.listSync();
  for (FileSystemEntity path in lis) {
    if (path is File) {
      final File f = path;

      final String base = basename(f.path);
      print('File name: $base');

      if (base.startsWith('workout_') && base.endsWith('.json')) {
        final String content = await f.readAsString();
        final Map x = jsonDecode(content);
        final json.Workout workout = json.Workout.fromJson(x);

        print('Inserting workout "${workout.title}" from ${workout.date}');

        try {
          // start transaction
          db.execute('BEGIN');

          // insert workout
          final int workoutId = await dbt.Workout(
            title: workout.title,
            date: workout.date,
            hasTime: workout.hasTime,
          ).insert(db);

          // insert all exercises
          for (json.Exercise exercise in workout.exercises) {
            final int exerciseId = await dbt.Exercise(
              workoutId: workoutId,
              exerciseId: exercise.id,
              exerciseName: exercise.name,
            ).insert(db);

            // insert all sets
            for (json.Set set in exercise.sets) {
              await dbt.Set(
                weight: set.weightKg,
                reps: set.repetitions,
                sets: set.sets,
                workoutExerciseId: exerciseId,
              ).insert(db);
            }
          }

          // store new data persistently
          db.execute('COMMIT');

          // return successful status
          foundNewFiles = true;

          // remove old file
          f.delete();

        } on DatabaseException catch (exc) {
          // roll back any errors
          db.execute('ROLLBACK');
          print(exc);
        }
      }
    }
  }

  return foundNewFiles;
}
