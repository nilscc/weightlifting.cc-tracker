import 'package:flutter/material.dart';

import 'widgets/workouts.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'weightlifting.cc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WorkoutsPage(title: 'weightlifting.cc'),
    );
  }

}