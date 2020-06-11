import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Workout {
  final String title;
  final DateTime date;

  Workout(this.title, this.date);

}

class Workouts extends ChangeNotifier {
  final List<Workout> workouts = [];

  void add(final Workout w) {
    workouts.add(w);

    notifyListeners();
  }
}

class WorkoutList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Workouts w = Provider.of<Workouts>(context);

    if (w.workouts.isEmpty)
      return ListTile(
        title: Text('No workouts yet.'),
      );
    else
      return ListView(
        children: w.workouts.map((w) => _workout(w)),
      );
  }

  Widget _workout(Workout w) => Text('Workout');
}
