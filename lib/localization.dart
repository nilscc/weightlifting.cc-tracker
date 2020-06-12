import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weightlifting.cc/l10n/messages_all.dart';

class DialogLocalizations {
  final String localeName;

  DialogLocalizations(this.localeName);

  static Future<DialogLocalizations> load(ui.Locale locale) async {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    await initializeMessages(localeName);
    return DialogLocalizations(localeName);
  }

  static DialogLocalizations of(BuildContext context) {
    return Localizations.of<DialogLocalizations>(context, DialogLocalizations);
  }

  static const DialogLocalizationsDelegate delegate = DialogLocalizationsDelegate();

  String get discardTitle => Intl.message("Discard changes?");
  String get discardContent => Intl.message("Unsaved changes will get lost.");
  String get discardButtonDiscard => Intl.message("Discard");
  String get discardButtonBack => Intl.message("Back");
}

class DialogLocalizationsDelegate extends LocalizationsDelegate<DialogLocalizations> {
  const DialogLocalizationsDelegate();

  @override
  bool isSupported(ui.Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<DialogLocalizations> load(ui.Locale locale) => DialogLocalizations.load(locale);

  @override
  bool shouldReload(DialogLocalizationsDelegate old) => false;
}