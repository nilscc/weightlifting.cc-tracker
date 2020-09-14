import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/json/workout.dart';
import 'package:weightlifting.cc/localization/delegate.dart';

import 'package:weightlifting.cc/pages/home.dart';
import 'package:weightlifting.cc/state/database_state.dart';

Future<void> storeDummyJsonFile() async {
  Workout w = Workout(DateTime.now(), true, 'Dummy Workout', [
    Exercise(1, null, [
      Set(20, 5),
      Set(40, 3),
      Set(50, 3),
      Set(60, 3),
    ]),
    Exercise(3, null, [
      Set(60, 2),
      Set(80, 1),
      Set(100, 1),
    ]),
  ]);

  Directory dir = await getApplicationDocumentsDirectory();
  String filename = '${dir.path}/workout_${DateTime.now().hashCode}.json';

  print('Storing dummy file at $filename');

  // write to file
  File(filename).writeAsString(jsonEncode(w));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugging options
  //await storeDummyJsonFile();
  //await deleteMainDatabase();

  // Set up time formatting with system locale
  Intl.defaultLocale = 'de'; //window.locale.toString(); // TODO

  // Run main app
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => DatabaseState(),
        builder: (context, _) => MaterialApp(
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
        ),
      );
}
