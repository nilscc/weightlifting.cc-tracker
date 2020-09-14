import 'package:sqflite/sqflite.dart';

class Workout {
  int id;
  DateTime date;
  bool hasTime;
  String title;

  Workout({this.id, this.date, this.hasTime, this.title});

  static final String _table = 'workouts';

  static Future<void> createTable(Database db) {
    return db.execute('CREATE TABLE $_table'
        '( id INTEGER PRIMARY KEY'
        ', date TEXT'
        ', hasTime INTEGER'
        ', title TEXT'
        ', UNIQUE (date, hasTime, title)'
        ')');
  }

  static Workout fromMap(Map<String, dynamic> map) => Workout(
        id: map['id'],
        date: DateTime.parse(map['date']),
        hasTime: map['hasTime'] == 0,
        title: map['title'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'hasTime': hasTime ? 0 : 1,
        'title': title,
      };

  Future<void> delete(Database db) async {
    assert(id != null);
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<Workout> query(Database db, final int workoutId) async {
    return (await db.query(_table,
            where: 'id = ?', whereArgs: [workoutId], limit: 1))
        .map((e) => fromMap(e))
        .toList()
        .first;
  }

  Future<int> insert(Database db) async {
    id = await db.insert(_table, toMap());
    return id;
  }

  Future<void> update(Database db) {
    return db.update(_table, toMap(), where: 'id = ?', whereArgs: [id]);
  }
}

class Exercise {
  int id;
  int workoutId;
  int exerciseId;
  String exerciseName;

  Exercise({this.id, this.workoutId, this.exerciseId, this.exerciseName});

  static final String _table = 'workout_exercises';

  static Future<void> createTable(Database db) {
    return db.execute('CREATE TABLE $_table'
        '( id INTEGER PRIMARY KEY'
        ', workout_id INTEGER'
        ', exercise_id INTEGER'
        ', exercise_name INTEGER'
        ', FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE'
        ', UNIQUE (workout_id, exercise_id, exercise_name)'
        ')');
  }

  static Exercise fromMap(Map<String, dynamic> map) => Exercise(
        id: map['id'],
        workoutId: map['workout_id'],
        exerciseId: map['exercise_id'],
        exerciseName: map['exercise_name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'workout_id': workoutId,
        'exercise_id': exerciseId,
        'exercise_name': exerciseName,
      };

  static Future<Exercise> query(Database db, final int setId) async {
    return (await db.query(_table,
            where: 'id = ?', whereArgs: [setId], limit: 1))
        .map((e) => fromMap(e))
        .toList()
        .first;
  }

  static Future<List<Exercise>> queryByWorkoutId(
      Database db, final int workoutId) async {
    var result =
        await db.query(_table, where: 'workout_id = ?', whereArgs: [workoutId]);
    print(result);
    return result.map((e) => fromMap(e)).toList();
  }

  Future<int> insert(Database db) async {
    id = await db.insert(_table, toMap());
    return id;
  }

  Future<void> update(Database db) {
    return db.update(_table, toMap(), where: 'id = ?', whereArgs: [id]);
  }
}

class Set {
  int id;
  int workoutExerciseId;
  int sets;
  int reps;
  double weight;

  Set({this.id, this.workoutExerciseId, this.sets, this.reps, this.weight});

  static final String _table = 'workout_exercise_sets';

  static Future<void> createTable(Database db) {
    return db.execute('CREATE TABLE $_table'
        '( id INTEGER PRIMARY KEY'
        ', workout_exercise_id INTEGER'
        ', sets INTEGER'
        ', reps INTEGER'
        ', weight REAL'
        ', FOREIGN KEY (workout_exercise_id) REFERENCES workout_exercises(id) ON DELETE CASCADE'
        ')');
  }

  static Set fromMap(Map<String, dynamic> map) => Set(
        id: map['id'],
        workoutExerciseId: map['workout_exercise_id'],
        sets: map['sets'],
        reps: map['reps'],
        weight: map['weight'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'workout_exercise_id': workoutExerciseId,
        'sets': sets,
        'reps': reps,
        'weight': weight,
      };

  static Future<Set> query(Database db, final int setId) async {
    return (await db.query(_table,
            where: 'id = ?', whereArgs: [setId], limit: 1))
        .map((e) => fromMap(e))
        .toList()
        .first;
  }

  static Future<List<Set>> queryByExerciseId(
      Database db, final int exerciseId) async {
    var lis = await db.query(_table,
        where: 'workout_exercise_id = ?', whereArgs: [exerciseId]);
    return lis.map((e) => fromMap(e)).toList();
  }

  Future<int> insert(Database db) async {
    id = await db.insert(_table, toMap());
    return id;
  }

  Future<void> update(Database db) {
    return db.update(_table, toMap(), where: 'id = ?', whereArgs: [id]);
  }
}
