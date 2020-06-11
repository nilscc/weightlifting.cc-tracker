import 'package:flutter/cupertino.dart';

class WorkoutDetails extends ChangeNotifier {
  bool _isModified = false;
  bool get isModified => _isModified;

  String _title;
  DateTime _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;
  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }
}

class WorkoutDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Details');
  }
}
