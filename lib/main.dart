import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/localization/delegate.dart';

import 'package:weightlifting.cc/pages/home.dart';
import 'package:weightlifting.cc/state/database_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
