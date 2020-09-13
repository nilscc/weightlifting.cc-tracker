import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';
import 'package:weightlifting.cc/state/set_state.dart';

class SetControlsWidget extends StatefulWidget {
  final BuildContext context;

  SetControlsWidget(this.context);

  @override
  _State createState() => _State(context);
}

class _State extends State<SetControlsWidget> {
  final BuildContext context;

  // configuration of slider increments
  final double minValue;
  final double increment;
  final int divisions;

  _State(this.context,
      {this.increment: 2.5, this.divisions: 8, this.minValue: 20.0});

  // read-only access to set state
  SetState get _set => SetState.of(context);
  ExerciseState get _exercise => ExerciseState.of(context);

  // internationalization messages
  WorkoutMessages get _workoutMessages => WorkoutMessages.of(context);

  // slider min value is manually set and updated
  double _sliderMin;

  // update according to current set weight
  void _updateMin() =>
      _sliderMin = max(minValue, _set.weight - 0.5 * divisions * increment);

  // slider max value is calculated based off of min value, divisions and increments
  double get _sliderMax => _sliderMin + divisions * increment;

  // keep track of current set ID
  int _activeSetId;

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text("${_workoutMessages.weightKg}:"),
                width: 110,
              ),
              _weightSlider(),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text("${_workoutMessages.repetitions}:"),
                width: 110,
              ),
              _repetitionControls(),
            ],
          ),
          ButtonBar(children: <Widget>[
            RaisedButton(
              child: Icon(Icons.content_copy),
              onPressed: _copyLastSet,
            ),
            FlatButton(
              child: Text(_workoutMessages.add2_5kg),
              onPressed: () => _copyLastSet(weightIncrement: 2.5),
            ),
            FlatButton(
              child: Text(_workoutMessages.add5kg),
              onPressed: () => _copyLastSet(weightIncrement: 5),
            ),
            FlatButton(
              child: Text(_workoutMessages.add10kg),
              onPressed: () => _copyLastSet(weightIncrement: 10),
            ),
          ]),
        ],
      );

  void _copyLastSet({double weightIncrement = 0.0, int repIncrement = 0}) {
    // append new set state
    _exercise.addSet(SetState(
      context,
      _set.weight + weightIncrement,
      _set.reps + repIncrement,
    ));

    // set next set as active
    _exercise.activeSetId += 1;
  }

  Widget _weightSlider() {
    // check if active set ID has changed
    if (_activeSetId != _exercise.activeSetId) {
      _updateMin();
      _activeSetId = _exercise.activeSetId;
    }

    return Expanded(
      child: Slider(
        value: _set.weight,
        min: _sliderMin,
        max: _sliderMax,
        divisions: divisions,
        onChanged: (value) => setState(() {
          // setState() is needed to update the UI of the slider
          _set.weight = value;
        }),
        onChangeEnd: (value) => setState(() {
          _updateMin();
        }),
      ),
    );
  }

  Widget _repetitionControls() => Expanded(
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: _set.incrementReps,
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: _set.decrementReps,
              icon: Icon(Icons.remove_circle_outline, color: Colors.grey),
            ),
          ],
        ),
      );
}
