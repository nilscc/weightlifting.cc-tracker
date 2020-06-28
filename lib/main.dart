import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:weightlifting.cc/localization/delegate.dart';

import 'package:weightlifting.cc/pages/home.dart';


void main() async {

  // Set up time formatting with system locale
  Intl.defaultLocale = window.locale.toString();

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
      supportedLocales: const [
        Locale('de'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        Loc.delegate,
      ],
      routes: {'/': (context) => HomePage(context)},
    );
  }

}