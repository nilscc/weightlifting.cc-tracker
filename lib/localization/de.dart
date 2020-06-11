


import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';


// LEGACY
const String DIALOG_DISCARD_TITLE = "Änderungen verwerfen?",
    DIALOG_DISCARD_CONTENT = "Nicht gespeicherte Änderungen gehen verloren.",
    DIALOG_DISCARD_BUTTON_DISCARD = "Verwerfen",
    DIALOG_DISCARD_BUTTON_BACK = "Zurück";



final messages = MessageLookup();

final _keepAnalysisHappy = Intl.defaultLocale;

typedef MessageIfAbsent(String messageStr, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'de';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => {
    "title" : MessageLookupByLibrary.simpleMessage("Hello World")
  };
}