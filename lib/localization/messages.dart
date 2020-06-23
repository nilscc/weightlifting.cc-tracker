import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weightlifting.cc/localization/delegate.dart';

class DialogMessages {

  static DialogMessages of(BuildContext context) => Loc.of(context).dialog;

  String get discardTitle => Intl.message("DIALOG_DISCARD_TITLE");
  String get discardContent => Intl.message("DIALOG_DISCARD_CONTENT");
  String get discardButtonDiscard =>
      Intl.message("DIALOG_DISCARD_BUTTON_DISCARD");
  String get discardButtonBack => Intl.message("DIALOG_DISCARD_BUTTON_BACK");

  Future<bool> showDiscardDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(discardTitle),
              content: Text(discardContent),
              actions: <Widget>[
                FlatButton(
                  child: Text(discardButtonDiscard),
                  onPressed: () => Navigator.pop(context, true),
                ),
                RaisedButton(
                  child: Text(discardButtonBack),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}

class HomeMessages {
  static HomeMessages of(BuildContext context) => Loc.of(context).home;

  String get noWorkouts => Intl.message(
        "HOME_NO_WORKOUTS",
        desc: "Message displayed when no workouts have been added yet.",
      );

  String get unregisteredTitle => Intl.message("HOME_UNREGISTERED_TITLE");
  String get unregisteredSubtitle => Intl.message("HOME_UNREGISTERED_SUBTITLE");
}

class WorkoutMessages {
  static WorkoutMessages of(BuildContext context) => Loc.of(context).workout;

  String get selectExercise => Intl.message("WORKOUT_SELECT_EXERCISE");

  String get repetitions => Intl.message("WORKOUT_REPETITIONS");
  String get weightKg => Intl.message("WORKOUT_WEIGHT_KG");

  String get add2_5kg => Intl.message("WORKOUT_SET_LIST_ADD_2_5KG");
  String get add5kg => Intl.message("WORKOUT_SET_LIST_ADD_5KG");
  String get add10kg => Intl.message("WORKOUT_SET_LIST_ADD_10KG");
}

class ExerciseMessages {
  static ExerciseMessages of(BuildContext context) => Loc.of(context).exercise;

  String get categoryK1 => Intl.message("EXERCISE_CATEGORY_K1_COMPETITION");
  String get exercise01 => Intl.message("EXERCISE_01_SNATCH");
  String get exercise02 => Intl.message("EXERCISE_02_SNATCH_WITH_STRAPS");
  String get exercise03 => Intl.message("EXERCISE_03_CLEAN_AND_JERK");
  String get exercise04 => Intl.message("EXERCISE_04_CLEAN");
  String get exercise05 => Intl.message("EXERCISE_05_JERK");

  String get categoryK2 => Intl.message("EXERCISE_CATEGORY_K2_PARTIAL");
  String get exercise06 => Intl.message("EXERCISE_06_SNATCH_HANG");
  String get exercise07 => Intl.message("EXERCISE_07_SNATCH_POWER");
  String get exercise08 => Intl.message("EXERCISE_08_SNATCH_HANG_HIGH");
  String get exercise09 => Intl.message("EXERCISE_09_CLEAN_HANG");
  String get exercise10 => Intl.message("EXERCISE_10_CLEAN_POWER");
  String get exercise11 => Intl.message("EXERCISE_11_CLEAN_HANG_HIGH");
  String get exercise12 => Intl.message("EXERCISE_12_JERK_POWER");

  String get categoryK3 => Intl.message("EXERCISE_CATEGORY_K3_PULLS");
  String get exercise13 => Intl.message("EXERCISE_13_SNATCH_PULL");
  String get exercise14 => Intl.message("EXERCISE_14_CLEAN_PULL");

  String get categoryK4 => Intl.message("EXERCISE_CATEGORY_K4");
  String get exercise15 => Intl.message("EXERCISE_15_SNATCH_DEADLIFT");
  String get exercise16 => Intl.message("EXERCISE_16_CLEAN_DEADLIFT");
  String get exercise17 => Intl.message("EXERCISE_17_JERK_SQUAT");

  String get categoryK5 => Intl.message("EXERCISE_CATEGORY_K5_SQUATS");
  String get exercise18 => Intl.message("EXERCISE_18_SQUAT_OVERHEAD");
  String get exercise19 => Intl.message("EXERCISE_19_SQUAT_FRONT");
  String get exercise20 => Intl.message("EXERCISE_20_SQUAT_BACK");
  String get exercise21 => Intl.message("EXERCISE_21_SQUAT_QUARTER");

  String get categoryK6 => Intl.message("EXERCISE_CATEGORY_K6_POWER");
  String get exercise22 => Intl.message("EXERCISE_22_SNATCH_PULL_POWER");
  String get exercise23 => Intl.message("EXERCISE_23_SNATCH_MUSCLE");
  String get exercise24 => Intl.message("EXERCISE_24_CLEAN_PULL_POWER");
  String get exercise25 => Intl.message("EXERCISE_25_PRESS");
  String get exercise26 => Intl.message("EXERCISE_26_PRESS_PUSH");

  String get categoryK7 => Intl.message("EXERCISE_CATEGORY_K7_COMPLEX");
  String get exercise27 => Intl.message("EXERCISE_27_CLEAN_FRONTSQUAT");
  String get exercise28 => Intl.message("EXERCISE_28_POWERCLEAN_POWERJERK");
  String get exercise29 => Intl.message("EXERCISE_29_FRONTSQUAT_JERK");

  Map<int, String> get _exerciseIds => {
        1: exercise01,
        2: exercise02,
        3: exercise03,
        4: exercise04,
        5: exercise05,
        6: exercise06,
        7: exercise07,
        8: exercise08,
        9: exercise09,
        10: exercise10,
        11: exercise11,
        12: exercise12,
        13: exercise13,
        14: exercise14,
        15: exercise15,
        16: exercise16,
        17: exercise17,
        18: exercise18,
        19: exercise19,
        20: exercise20,
        21: exercise21,
        22: exercise22,
        23: exercise23,
        24: exercise24,
        25: exercise25,
        26: exercise26,
        27: exercise27,
        28: exercise28,
        29: exercise29,
      };

  String exercise(int exerciseId) => _exerciseIds[exerciseId];

  Map<int, String> get _categoryIds => {
        1: categoryK1,
        2: categoryK2,
        3: categoryK3,
        4: categoryK4,
        5: categoryK5,
        6: categoryK6,
        7: categoryK7,
      };

  String category(int categoryId) => _categoryIds[categoryId];

  List<int> get categoryIds => _categoryIds.keys.toList();
  List<String> get categoryNames => _categoryIds.values.toList();

  Map<int, List<int>> get _categoryExercises => {
        1: [1, 2, 3, 4, 5],
        2: [6, 7, 8, 9, 10, 11, 12],
        3: [13, 14],
        4: [15, 16, 17],
        5: [18, 19, 20, 21],
        6: [22, 23, 24, 25, 26],
        7: [27, 28, 29],
      };

  List<int> categoryExercises(int categoryId) => _categoryExercises[categoryId];
}
