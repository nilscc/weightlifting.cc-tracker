// Tests for workout state

import 'package:flutter_test/flutter_test.dart';
import 'package:weightlifting.cc/state/workout_state.dart';

void main() {
  test('Verify modified state on workout details', () {
    // Main workout state instance to test
    WorkoutState workout = WorkoutState(null);

    workout.dateTime = DateTime.now();
    workout.title = 'test';
  });
}
