import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exercise {
  final int number;
  final String name;
  const Exercise(this.number, this.name);
}

class Category {
  final String name;
  final List<Exercise> exercises;

  const Category(this.name, this.exercises);
}

const List<Category> CATEGORIES = [
  Category('K1 - Wettkampfübungen', [
    Exercise(1, 'Reißen'),
    Exercise(2, 'Reißen mit Bändern'),
    Exercise(3, 'Stoßen'),
    Exercise(4, 'Umsetzen'),
    Exercise(5, 'Ausstoßen'),
  ]),
  Category('K2 - Teilübungen', [
    Exercise(6, 'Reißen erhöht'),
    Exercise(7, 'Standreißen'),
    Exercise(8, 'Umgruppieren breit'),
    Exercise(9, 'Umsetzen erhöht'),
    Exercise(10, 'Standumsetzen'),
    Exercise(11, 'Umgruppieren eng'),
    Exercise(12, 'Standstoßen'),
  ]),
  Category('K3 - Züge', [
    Exercise(13, 'Zug breit'),
    Exercise(14, 'Zug end'),
  ]),
  Category('K4 - Lastheben', [
    Exercise(15, 'Lastheben breit'),
    Exercise(16, 'Lastheben end'),
    Exercise(17, 'Anstoßkniebeuge'),
  ]),
  Category('K5 - Kniebeugen', [
    Exercise(18, 'Reißkniebeuge'),
    Exercise(19, 'Kniebeuge vorn'),
    Exercise(20, 'Kniebeuge hinten'),
    Exercise(21, 'Halbkniebeuge'),
  ]),
  Category('K6 - Power', [
    Exercise(22, 'Powerzug breit'),
    Exercise(23, 'Kraftreißen'),
    Exercise(24, 'Powerzug end'),
    Exercise(25, 'Kraftdrücken'),
    Exercise(26, 'Schwungdrucken'),
  ]),
  Category('K7 - Komplex', [
    Exercise(27, 'Umsetzen + Kniebeuge vorn'),
    Exercise(28, 'Standumsetzen + Standstoßen'),
    Exercise(29, 'Kniebeuge vorn + Ausstoßen'),
  ]),
];

class ExerciseSelectorPage extends StatefulWidget {
  ExerciseSelectorPage({Key key}) : super(key: key);

  @override
  _ExerciseSelectorState createState() => _ExerciseSelectorState();
}

class _ExerciseSelectorState extends State<ExerciseSelectorPage> {
  _ExerciseSelectorState()
      : _expanded = 0;

  int _expanded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      body: ListView(children: <Widget>[
        _buildCategories(context),
      ]),
    );
  }

  Widget _buildCategories(BuildContext context) => ExpansionPanelList(
        expansionCallback: (idx, isExpanded) {
          if (_expanded != idx)
            setState(() {
              _expanded = idx;
            });
        },
        children: CATEGORIES
            .asMap()
            .map((idx, cat) => MapEntry(idx, _category(idx, cat)))
            .values
            .toList(),
      );

  ExpansionPanel _category(final int idx, final Category cat) => ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: _expanded == idx,
        headerBuilder: (BuildContext context, bool isExpanded) =>
            ListTile(title: Text('${cat.name}')),
        body: Column(
          children: cat.exercises
              .map((e) => FlatButton(
                    onPressed: () {
                      Navigator.pop(context, e);
                    },
                    child: Center(
                      child: Text('${e.number} - ${e.name}'),
                    ),
                  ))
              .toList(),
        ),
      );
}
