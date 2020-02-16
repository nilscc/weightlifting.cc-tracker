import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddWorkoutPage extends StatefulWidget {
  AddWorkoutPage({Key key}) : super(key: key);

  final String title = 'Add Workout';

  @override
  _AddWorkoutPageState createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {

  DateTime _date = DateTime.now();
  TimeOfDay _time = null;

  void save() {}

  AppBar buildAppBar() {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: save,
        ),
      ],
    );
  }

  String formattedDateTime() {
    if (_time == null) {
      return DateFormat.yMd().format(_date);
    }
    else {
      return DateFormat.yMd().add_jm().format(DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute));
    }
  }

  Widget buildAddTime(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.access_time),
      onPressed: () async {
        final TimeOfDay newTime = await showTimePicker(
            context: context,
            initialTime: _time != null ? _time : TimeOfDay.now());

        setState(() {
          _time = newTime;
        });
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return Card(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.calendar_today),
            trailing: buildAddTime(context),
            onTap: () async {
              final DateTime newDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now());

              if (newDate != null) {
                setState(() {
                  _date = newDate;
                });
              }
            },
            title: Text('${formattedDateTime()}'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }
}
