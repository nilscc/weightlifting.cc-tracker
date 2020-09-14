import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weightlifting.cc/localization/messages.dart';
import 'package:weightlifting.cc/state/workout_state.dart';

class WorkoutDetailsWidget extends StatelessWidget {
  final BuildContext context;

  WorkoutDetailsWidget(this.context);

  WorkoutState get _state => WorkoutState.of(context, listen: true);
  WorkoutState get _stateRO => WorkoutState.of(context);
  WorkoutMessages get _message => WorkoutMessages.of(context);

  String _formatDateTime() {
    if (_state.hasTime)
      return DateFormat.yMd().add_jm().format(_state.dateTime);
    else
      return DateFormat.yMd().format(_state.dateTime);
  }

  // get initial time of day, rounded down to previous half hour
  TimeOfDay get _initialTime => TimeOfDay(
      hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute < 30 ? 0 : 30);

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
                    _stateRO.time = await showTimePicker(
                        context: context, initialTime: _initialTime);
                  },
                ),
                title: Text(_formatDateTime()),
                onTap: () async {
                  final DateTime newDate = await showDatePicker(
                    context: context,
                    initialDate: _initialDate,
                    firstDate: DateTime.now().subtract(Duration(days: 5 * 365)),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (newDate != null) {
                    if (_stateRO.hasTime)
                      _stateRO.dateTime = DateTime(
                          newDate.year,
                          newDate.month,
                          newDate.day,
                          _stateRO.dateTime.hour,
                          _stateRO.dateTime.minute);
                    else
                      _stateRO.dateTime = newDate;
                  }
                },
              ),
              TextFormField(
                initialValue: _stateRO.title,
                onChanged: (String value) => _stateRO.title = value,
                decoration: InputDecoration(
                  labelText: _message.workoutTitleLabel,
                ),
              ),
            ],
          ),
        ),
      );
}
