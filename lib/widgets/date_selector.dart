import 'package:flutter/material.dart';
import 'package:flutter_app/change_notifier/new_workout.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateSelectorWidget extends StatelessWidget {
  DateSelectorWidget({Key key}) : super(key: key);

  String _format(DateTime date, {hasTime: false}) {
    if (hasTime)
      return DateFormat.yMd().add_jm().format(date);
    else
      return DateFormat.yMd().format(date);
  }

  void _updateDate(BuildContext context, DateTime date, {bool hasTime: false}) {
    Provider.of<NewWorkout>(context, listen: false).setDateTime(date, hasTime: hasTime);
  }

  void _updateTime(BuildContext context, TimeOfDay newTime) {
    Provider.of<NewWorkout>(context, listen: false).setTime(newTime);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.calendar_today),
      trailing: IconButton(
        icon: Icon(Icons.access_time),
        onPressed: () async {
          final TimeOfDay newTime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());

          _updateTime(context, newTime);
        },
      ),
      onTap: () async {
        final DateTime newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now());

        if (newDate != null) _updateDate(context, newDate);
      },
      title: Consumer<NewWorkout>(
          builder: (context, workout, child) =>
              Text('${_format(workout.date(), hasTime: workout.hasTime())}'),
      ),
    );
  }
}
