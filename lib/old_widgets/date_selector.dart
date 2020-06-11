import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateWithOptionalTime extends ChangeNotifier {
  DateTime dateTime;
  bool hasTimeSet;

  DateWithOptionalTime({this.dateTime, this.hasTimeSet: false})
  {
    if (this.dateTime == null)
    {
      this.dateTime = DateTime.now();
    }
  }

  String format() {
    if (hasTimeSet)
      return DateFormat.yMd().add_jm().format(dateTime);
    else
      return DateFormat.yMd().format(dateTime);
  }

  void setDate(DateTime dateTime, {bool hasTimeSet})
  {
    this.dateTime = dateTime;
    if (hasTimeSet != null) this.hasTimeSet = hasTimeSet;

    notifyListeners();
  }

  void setTime(TimeOfDay timeOfDay)
  {
    this.dateTime = DateTime(this.dateTime.year, this.dateTime.month, this.dateTime.day, timeOfDay.hour, timeOfDay.minute);
    this.hasTimeSet = true;

    notifyListeners();
  }
}

class DateSelectorWidget extends StatelessWidget {
  DateSelectorWidget({Key key}) : super(key: key);

  void _updateDate(BuildContext context) async {

    final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (newDate != null)
      Provider.of<DateWithOptionalTime>(context, listen: false)
          .setDate(newDate, hasTimeSet: false);
  }

  void _updateTime(BuildContext context) async {

    final TimeOfDay newTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.now());

    Provider.of<DateWithOptionalTime>(context, listen: false)
        .setTime(newTime);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DateWithOptionalTime>(
      builder: (context, date, child) => ListTile(
        leading: Icon(Icons.calendar_today),
        trailing: IconButton(
          icon: Icon(Icons.access_time),
          onPressed: () => _updateTime(context),
        ),
        onTap: () => _updateDate(context),
        title: Text('${date.format()}'),
      ),
    );
  }
}
