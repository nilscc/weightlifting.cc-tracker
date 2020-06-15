import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/set_state.dart';

class SetWidget extends StatefulWidget {
  final BuildContext context;

  SetWidget(this.context);

  @override
  State<StatefulWidget> createState() => _State(context);
}

class _State extends State<SetWidget> {
  final BuildContext context;

  final double minValue;
  final double increment;
  final int divisions;

  _State(this.context,
      {this.increment: 2.5, this.divisions: 8, this.minValue: 20.0});

  // read-only access to set state
  SetState get _state => SetState.of(context);

  double _sliderMin;

  double get _sliderMax => max(minValue + divisions * increment,
      (_sliderMin ?? minValue) + divisions * increment);

  WorkoutMessages get _msg => WorkoutMessages.of(context);

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          _buildWeightControls(),
          _buildRepetitionControls(),
        ],
      );

  Widget _buildWeightControls() => Row(
        children: <Widget>[
          Text("${_msg.weightKg}:"),
          Expanded(
            child: Slider(
              value: SetState.of(context, listen: true).weight,
              min: _sliderMin == null ? minValue : max(minValue, _sliderMin),
              max: _sliderMax,
              divisions: divisions,
              onChanged: (value) {
                _state.weight = value;
              },
              onChangeEnd: (value) => setState(() {
                _sliderMin = max(minValue, value - divisions / 2 * increment);
              }),
            ),
          ),
        ],
      );

  Widget _buildRepetitionControls() => Row(
        children: <Widget>[
          Text("${_msg.repetitions}:"),
          IconButton(
            onPressed: _state.incrementReps,
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: _state.decrementReps,
            icon: Icon(Icons.remove_circle_outline, color: Colors.grey),
          ),
        ],
      );
}
