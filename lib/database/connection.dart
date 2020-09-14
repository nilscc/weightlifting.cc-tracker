import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weightlifting.cc/database/types.dart';

Future<void> deleteMainDatabase() async =>
    deleteDatabase(join(await getDatabasesPath(), 'weightlifting_cc_main.db'));

Future<Database> connect() async =>
    openDatabase(join(await getDatabasesPath(), 'weightlifting_cc_main.db'),
        version: 1, onCreate: (db, version) async {
      await Workout.createTable(db);
      await Exercise.createTable(db);
      await Set.createTable(db);
    });
