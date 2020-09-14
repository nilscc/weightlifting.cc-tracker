import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weightlifting.cc/database/migrate_json_files.dart';
import 'package:weightlifting.cc/database/storage.dart';
import 'package:weightlifting.cc/pages/home/workout_list.dart';
import 'package:weightlifting.cc/state/database_state.dart';

class SyncWidget extends StatefulWidget {
  final BuildContext context;

  SyncWidget(this.context);

  @override
  _State createState() => _State(context);
}

class _State extends State<SyncWidget> {
  final BuildContext context;

  _State(this.context) {
    // use small delay to make sure to run sync in background
    Future.delayed(Duration(milliseconds: 1)).then((value) => _startSync());
  }

  // current database connection
  DatabaseState get _db => DatabaseState.of(context);

  // UI data
  IconData _icon = Icons.info;
  String _title = 'Synchronizing...';
  Color _color = Colors.blue;

  bool _visible = true;

  @override
  Widget build(BuildContext context) => _visible ? _buildCard() : _buildHidden();

  Widget _buildHidden() => Column();

  Widget _buildCard() => Card(
        color: _color,
        child: ListTile(
          onTap: _onTap,
          leading: Icon(_icon, color: Colors.white),
          title: Text(
            _title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );

  Future<void> Function() _onTap;

  Future<void> _startSync() async {

    Database db = await _db.database;

    setState(() {
      _title = "Checking for JSON files";
    });

    bool newJsonFiles = await migrateJsonFiles(db);

    if (newJsonFiles)
      // update workouts list
      await Workouts.of(context).load(db);

    setState(() {
      _title = "Done.";
      _onTap = _listDBEntries;
    });
  }

  Future<void> _listDBEntries() async {
    allWorkouts(await _db.database);
  }
}
