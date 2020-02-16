import 'package:flutter/material.dart';

class AddWorkoutPage extends StatefulWidget {
  AddWorkoutPage({Key key}) : super(key: key);

  final String title = 'Add Workout';

  @override
  _AddWorkoutPageState createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
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

  Future<Widget> buildBody(BuildContext context) async {

    final DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now());

    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 50,
              child: Text('Date:'),
            ),
            Container(
              child: Text('${date.day}.${date.month}.${date.year}'),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder<Widget>(
        future: buildBody(context),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          }
          else {
            return Center(
                child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}
