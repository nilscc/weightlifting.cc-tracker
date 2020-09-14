import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';
import 'package:weightlifting.cc/json/workout.dart';

Future<List<Tuple2<int, Workout>>> allWorkouts(Database db, {int limit}) async {
  List<Tuple2<int, Workout>> workouts = [];

  for (Map w
      in await db.query('workouts', limit: limit, orderBy: 'date DESC')) {
    List<Exercise> exercises = [];

    for (Map e in await db.query('workout_exercises',
        where: 'workout_id = ?', whereArgs: [w['id']])) {
      List<Set> sets = [];

      for (Map s in await db.query('workout_exercise_sets',
          where: 'workout_exercise_id = ?', whereArgs: [e['id']])) {
        sets.add(Set(s['weight'], s['reps'], sets: s['sets]']));
      }

      exercises.add(Exercise(e['exercise_id'], e['exercise_name'], sets));
    }

    workouts.add(Tuple2(
        w['id'],
        Workout(DateTime.parse(w['date']), w['hasTime'] == 0, w['title'],
            exercises)));
  }

  return workouts;
}

//Future<int> insertWorkout(Database db, final Workout workout) {
//  return db.insert('workouts', {
//    'date': workout.date.toIso8601String(),
//    'hasTime': workout.hasTime ? 1 : 0,
//    'title': workout.title,
//  });
//}
//
//Future<void> updateWorkout(
//    Database db, final int workoutId, final Workout workout) {
//  return db.update(
//      'workouts',
//      {
//        'date': workout.date.toIso8601String(),
//        'hasTime': workout.hasTime ? 1 : 0,
//        'title': workout.title,
//      },
//      where: 'id = ?',
//      whereArgs: [workoutId]);
//}
//
//Future<int> insertExercise(
//    Database db, final int workoutId, final Exercise exercise) {
//  return db.insert('workout_exercises', {
//    'workout_id': workoutId,
//    'exercise_id': exercise.id,
//    'exercise_name': exercise.name,
//  });
//}
//
//Future<void> updateExercise(
//    Database db, final int exerciseId, final Exercise exercise) {
//  return db.update(
//      'workout_exercises',
//      {
//        'exercise_id': exercise.id,
//        'exercise_name': exercise.name,
//      },
//      where: 'id = ?',
//      whereArgs: [exerciseId]);
//}
//
//Future<int> insertSet(Database db, final int exerciseId, final Set set) {
//  return db.insert('workout_exercise_sets', {
//    'workout_exercise_id': exerciseId,
//    'sets': set.sets,
//    'reps': set.repetitions,
//    'weight': set.weightKg,
//  });
//}
//
//Future<void> updateSet(Database db, final int setId, final Set set) {
//  return db.update(
//      'workout_exercise_sets',
//      {
//        'sets': set.sets,
//        'reps': set.repetitions,
//        'weight': set.weightKg,
//      },
//      where: 'id = ?',
//      whereArgs: [setId]);
//}
