import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'widgets/workouts.dart';

void main() async {

  // Set up time formatting with system locale
  Intl.defaultLocale = window.locale.toString();
  await initializeDateFormatting(Intl.defaultLocale);

  // Run main app
  runApp(MainApp());
}

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