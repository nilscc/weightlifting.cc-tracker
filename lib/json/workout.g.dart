// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['title'] as String,
    (json['exercises'] as List)
        ?.map((e) =>
            e == null ? null : Exercise.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'title': instance.title,
      'exercises': instance.exercises,
    };

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return Exercise(
    json['id'] as int,
    json['name'] as String,
    (json['sets'] as List)
        ?.map((e) => e == null ? null : Set.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sets': instance.sets,
    };

Set _$SetFromJson(Map<String, dynamic> json) {
  return Set(
    (json['weight_kg'] as num)?.toDouble(),
    json['repetitions'] as int,
  );
}

Map<String, dynamic> _$SetToJson(Set instance) => <String, dynamic>{
      'weight_kg': instance.weightKg,
      'repetitions': instance.repetitions,
    };
