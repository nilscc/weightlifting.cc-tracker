import 'package:flutter/material.dart';

class NewWorkout extends ChangeNotifier {

  DateTime _date = DateTime.now();
  DateTime date() => _date;

  bool _hasTime = false;
  bool hasTime() => _hasTime;

  void save() {}

  void setDateTime(DateTime date, {bool hasTime: false}) {
    if (date != null && (date != _date || hasTime != _hasTime)) {

      _date = date;
      _hasTime = hasTime;

      notifyListeners();
    }
  }

  void setTime(TimeOfDay time) {
    if (time != null)
      setDateTime(DateTime(_date.year, _date.month, _date.day, time.hour, time.minute), hasTime: true);
    else
      setDateTime(_date, hasTime: false);
  }

  // TODO
  static
  List<String> exercises () {
    return [
      'Snatch',
      'Clean & Jerk',
      'Squat',
    ];
  }
}