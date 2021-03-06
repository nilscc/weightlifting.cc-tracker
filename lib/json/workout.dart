import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

@JsonSerializable(explicitToJson: true)
class Workout {

  Workout(this.date, this.hasTime, this.title, this.exercises);

  final DateTime date;

  @JsonKey(defaultValue: false)
  final bool hasTime;

  @JsonKey(required: false)
  final String title;

  final List<Exercise> exercises;

  // Serialization methods
  factory Workout.fromJson(Map<String, dynamic> json) => _$WorkoutFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

}

@JsonSerializable(explicitToJson: true)
class Exercise {

  Exercise(this.id, this.name, this.sets);

  @JsonKey(required: false)
  final int id;

  @JsonKey(required: false)
  final String name;

  final List<Set> sets;

  // Serialization methods
  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Set {
  Set(this.weightKg, this.repetitions, {this.sets: 1});

  final double weightKg;
  final int repetitions;
  final int sets;

  double weightLbs() => weightKg * 2.20462262485;

  // Serialization methods
  factory Set.fromJson(Map<String, dynamic> json) => _$SetFromJson(json);
  Map<String, dynamic> toJson() => _$SetToJson(this);
}