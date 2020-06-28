import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/workout_state.dart';

class WorkoutDetailsWidget extends StatelessWidget {
  final BuildContext context;

  WorkoutDetailsWidget(this.context);

  WorkoutState get _state => WorkoutState.of(context);
  WorkoutMessages get _message => WorkoutMessages.of(context);

  String _formatDateTime() {
    if (_state.hasTime)
      return DateFormat.yMd().add_jm().format(_state.dateTime);
    else
      return DateFormat.yMd().format(_state.dateTime);
  }

  // get initial time of day, rounded down to previous half hour
  TimeOfDay get _initialTime => TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute < 30 ? 0 : 30);

  DateTime get _initialDate => DateTime.now();

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.calendar_today),
                trailing: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () async {
                    _state.time = await showTimePicker(context: context, initialTime: _initialTime);
                  },
                ),
                title: Text(_formatDateTime()),
                onTap: () async {
                  final DateTime newDate = await showDatePicker(
                      context: context,
                      initialDate: _initialDate,
                      firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  _state.dateTime = newDate;
                },
              ),
              TextField(
                onSubmitted: (String value) => _state.title = value,
                decoration: InputDecoration(
                  labelText: _message.workoutTitleLabel,
                ),
              ),
            ],
          ),
        ),
      );
}
