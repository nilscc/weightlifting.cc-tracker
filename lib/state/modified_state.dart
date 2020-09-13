import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifiedState extends ChangeNotifier {

  /// Get ModifiedState of current context
  static ModifiedState of(final BuildContext context,
          {final bool listen: false}) =>
      Provider.of<ModifiedState>(context, listen: listen);

  bool _modified = false;

  bool get modified => _modified;

  set modified(final bool newValue) {
    if (newValue != _modified) {
      _modified = newValue;
      notifyListeners();
    }
  }
}
