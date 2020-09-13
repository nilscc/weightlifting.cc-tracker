// Tests for exercise state

import 'package:flutter_test/flutter_test.dart';
import 'package:weightlifting.cc/state/exercise_state.dart';

void main() {
  test('Verify empty state', () {
    ExerciseState exercise = ExerciseState(null);
    expect(exercise.hasExerciseId, false);
  });
}