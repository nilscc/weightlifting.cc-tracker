import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

@JsonSerializable()
class Workout {

  Workout(this.date, this.title, this.exercises);

  final DateTime date;

  @JsonKey(required: false)
  final String title;

  final List<Exercise> exercises;

  // Serialization methods
  factory Workout.fromJson(Map<String, dynamic> json) => _$WorkoutFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}

@JsonSerializable()
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

@JsonSerializable()
class Set {
  Set(this.weight_kg, this.repetitions);

  final double weight_kg;
  final int repetitions;

  double weight_lbs() => weight_kg * 2.20462262485;

  // Serialization methods
  factory Set.fromJson(Map<String, dynamic> json) => _$SetFromJson(json);
  Map<String, dynamic> toJson() => _$SetToJson(this);
}