import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
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
          'Unregistered Account',
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        onTap: _openRegistration,
        subtitle: Text(
          'Tap to register with your email address. Otherwise your workouts may get lost!',
          style: TextStyle(color: color),
        ),
      ),
    );
  }

  void _openRegistration() {
    print('Open registration...');
  }
}
