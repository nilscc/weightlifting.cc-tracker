import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weightlifting.cc/json/workout.dart';
import 'package:weightlifting.cc/old_pages/add_workout.dart';
import 'package:provider/provider.dart';

class ExerciseTile extends StatefulWidget {
  final int exerciseIndex;

  ExerciseTile(this.exerciseIndex, {Key key}) : super(key: key);

  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  bool _isExpanded = true;

  Exercise exercise(context) =>
      Provider.of<WorkoutState>(context, listen: false)
          .exercise(widget.exerciseIndex);

  Widget _set(final double weightKg, final int reps) {
    return TextField(
      decoration: InputDecoration(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }

  Widget _defaultSet() => _set(20.0, 0);

  List<Widget> _sets(BuildContext context) {
    final sets = exercise(context).sets;

    if (sets.length == 0)
      return [_defaultSet()];
    else
      return sets.map((set) => _set(set.weight_kg, set.repetitions)).toList();
  }

  Widget _nextSetControls(BuildContext context) => ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(child: Icon(Icons.content_copy)),
          FlatButton(child: Text('+2.5kg')),
          FlatButton(child: Text('+5kg')),
          FlatButton(child: Text('+10kg')),
        ],
      );

  @override
  Widget build(BuildContext context) => Card(
        child: ExpansionPanelList(
          expansionCallback: (_, expanded) {
            setState(() {
              _isExpanded = !expanded;
            });
          },
          children: [
            ExpansionPanel(
              isExpanded: _isExpanded,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) => ListTile(
                title: Text(exercise(context).name), //widget.exerciseIndex)
              ),
              body: Column(
                  children:
                      _sets(context) + <Widget>[_nextSetControls(context)]),
            )
          ],
        ),
      );
}
