// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['hasTime'] as bool ?? false,
    json['title'] as String,
    (json['exercises'] as List)
        ?.map((e) =>
            e == null ? null : Exercise.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'hasTime': instance.hasTime,
      'title': instance.title,
      'exercises': instance.exercises?.map((e) => e?.toJson())?.toList(),
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
      'sets': instance.sets?.map((e) => e?.toJson())?.toList(),
    };

Set _$SetFromJson(Map<String, dynamic> json) {
  return Set(
    (json['weightKg'] as num)?.toDouble(),
    json['repetitions'] as int,
  );
}

Map<String, dynamic> _$SetToJson(Set instance) => <String, dynamic>{
      'weightKg': instance.weightKg,
      'repetitions': instance.repetitions,
    };
