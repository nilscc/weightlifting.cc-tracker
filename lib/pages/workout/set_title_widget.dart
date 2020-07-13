import 'package:flutter/material.dart';
import 'package:weightlifting.cc/state/set_state.dart';

class SetTitleWidget extends StatelessWidget {
  final BuildContext context;
  final bool active;

  SetTitleWidget(this.context, {this.active: false});

  // read-only access to set state
  SetState get _state => SetState.of(context, listen: true);

  @override
  Widget build(BuildContext context) => active ? _buildActive() : _buildInactive();

  Widget _buildInactive() => Container(
        child: Column(
          children: <Widget>[
            Text(_state.weight.toStringAsFixed(1)),
            Divider(height: 4, color: Colors.black,),
            Text(_state.reps.toString()),
          ],
        ),
        width: 50,
      );

  Widget _buildActive() => Row(
    children: [
      _buildInactive()
    ],
  );

//  Text('${_state.weight.toStringAsFixed(1)} x ${_state.reps}');
}
