import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weightlifting.cc/localization/delegate.dart';

class HomeMessages {

  static HomeMessages of(BuildContext context) => Loc.of(context).home;

  String get noWorkouts => Intl.message("HOME_NO_WORKOUTS",
    desc: "Message displayed when no workouts have been added yet.",
  );

  String get unregisteredTitle => Intl.message("HOME_UNREGISTERED_TITLE");
  String get unregisteredSubtitle => Intl.message("HOME_UNREGISTERED_SUBTITLE");

}

class WorkoutMessages {

  static WorkoutMessages of(BuildContext context) => Loc.of(context).workout;

  String get popDialogDiscardTitle => Intl.message("WORKOUT_POP_DIALOG_DISCARD_TITLE");
  String get popDialogDiscardContent => Intl.message("WORKOUT_POP_DIALOG_DISCARD_CONTENT");
  String get popDialogDiscardButtonDiscard => Intl.message("WORKOUT_POP_DIALOG_DISCARD_BUTTON_DISCARD");
  String get popDialogDiscardButtonBack => Intl.message("WORKOUT_POP_DIALOG_DISCARD_BUTTON_BACK");

}