import 'package:flutter/material.dart';
import 'package:weightlifting.cc/localization/messages.dart';

class LoginHeader extends StatelessWidget {

  final BuildContext context;

  LoginHeader(this.context) : assert(context != null);

  HomeMessages get loc => HomeMessages.of(context);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color color = Colors.white;

    return Card(
      color: theme.errorColor,
      borderOnForeground: false,
      child: ListTile(
        leading: Icon(
          Icons.warning,
          color: color,
        ),
        title: Text(
          loc.unregisteredTitle,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        onTap: _openRegistration,
        subtitle: Text(loc.unregisteredSubtitle,
          style: TextStyle(color: color),
        ),
      ),
    );
  }

  void _openRegistration() {
    print('Open registration...');
  }
}
