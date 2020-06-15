import 'package:flutter/material.dart';
import 'package:weightlifting.cc/state/set_state.dart';

class SetTitleWidget extends StatelessWidget {

  final BuildContext context;

  SetTitleWidget(this.context);

  // read-only access to set state
  SetState get _state => SetState.of(context, listen: true);

  @override
  Widget build(BuildContext context) => Text('${_state.weight.toStringAsFixed(1)} x ${_state.reps}');
}