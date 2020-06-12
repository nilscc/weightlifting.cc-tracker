import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weightlifting.cc/l10n/messages_all.dart';
import 'package:weightlifting.cc/localization/messages.dart';

/// Primary localization class, which loads all l10n messages
class Loc {
  final String localeName;

  Loc(this.localeName);

  static Future<Loc> load(ui.Locale locale) async {
    final String name = (locale.countryCode == null) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    await initializeMessages(localeName);
    return Loc(localeName);
  }

  static Loc of(BuildContext context) {
    return Localizations.of<Loc>(context, Loc);
  }

  static const _Del delegate = _Del();

  final HomeMessages home = HomeMessages();
  final WorkoutMessages workout = WorkoutMessages();

}

/// Delegate class required for initialization
class _Del extends LocalizationsDelegate<Loc> {
  const _Del();

  @override
  bool isSupported(ui.Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<Loc> load(ui.Locale locale) => Loc.load(locale);

  @override
  bool shouldReload(_Del old) => false;
}