// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "HOME_NO_WORKOUTS" : MessageLookupByLibrary.simpleMessage("Keine Workouts gespeichert."),
    "HOME_UNREGISTERED_SUBTITLE" : MessageLookupByLibrary.simpleMessage("Bitte registriere deinen Account mit einer Emailadresse um Workouts langfristig zu sichern."),
    "HOME_UNREGISTERED_TITLE" : MessageLookupByLibrary.simpleMessage("Account nicht registriert."),
    "WORKOUT_POP_DIALOG_DISCARD_BUTTON_BACK" : MessageLookupByLibrary.simpleMessage("Zurück"),
    "WORKOUT_POP_DIALOG_DISCARD_BUTTON_DISCARD" : MessageLookupByLibrary.simpleMessage("Verwerfen"),
    "WORKOUT_POP_DIALOG_DISCARD_CONTENT" : MessageLookupByLibrary.simpleMessage("Nicht gespeicherte Änderungen gehen verloren."),
    "WORKOUT_POP_DIALOG_DISCARD_TITLE" : MessageLookupByLibrary.simpleMessage("Änderungen verwerfen?")
  };
}
