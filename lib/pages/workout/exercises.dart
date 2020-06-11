import 'package:flutter/cupertino.dart';

class Exercises extends ChangeNotifier {
  bool _isModified = false;
  bool get isModified => _isModified;

  int get count => 0;
}

class ExercisesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Exercises');
  }
}
