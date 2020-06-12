import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightlifting.cc/localization/messages.dart';

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

  final BuildContext context;

  WorkoutList(this.context) : assert(context != null);

  HomeMessages get loc => HomeMessages.of(context);

  Workouts get _state => Provider.of<Workouts>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    if (_state.workouts.isEmpty)
      return ListTile(
        title: Text(loc.noWorkouts),
      );
    else
      return ListView(
        children: _state.workouts.map((w) => _workout(w)),
      );
  }

  Widget _workout(Workout w) => Text('Workout');
}
