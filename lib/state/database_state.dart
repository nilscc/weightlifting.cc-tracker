import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weightlifting.cc/database/connection.dart';

class DatabaseState extends ChangeNotifier {
  Future<Database> _database = connect();

  Future<Database> get database => _database;

  static DatabaseState of(BuildContext context) =>
      Provider.of<DatabaseState>(context, listen: false);
}
