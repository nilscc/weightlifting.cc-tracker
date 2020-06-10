import 'package:flutter/material.dart';

class ExercisesPage extends StatefulWidget {
  ExercisesPage({Key key}) : super(key: key);

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trainingsmittelkatalog"),
      ),
    );
  }
}