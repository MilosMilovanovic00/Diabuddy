import 'package:diabuddy/model/enitity/activity.dart';
import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/model/enitity/enum/meal_type.dart';
import 'package:equatable/equatable.dart';

class GlucoseReading extends Equatable {
  final String? id;
  final DateTime entryTime;
  final double glucoseValue;
  final GlucoseTiming glucoseTiming;
  final Activity? activity;
  final MealType? mealType;
  // final List<String>? dishes;

  const GlucoseReading({
    this.id,
    required this.entryTime,
    required this.glucoseValue,
    required this.glucoseTiming,
    this.mealType,
    this.activity,
  });

  @override
  List<Object?> get props => [
        entryTime,
        glucoseValue,
        glucoseTiming,
        activity,
      ];

  factory GlucoseReading.fromMap(map, String id) {
    return GlucoseReading(
      id: id,
      entryTime: map['entryTime'],
      glucoseValue: map['glucoseValue'],
      glucoseTiming: GlucoseTiming.values[map['glucoseTiming']],
      activity: Activity.fromMap(map['activity']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'entryTime': entryTime,
      'glucoseValue': glucoseValue,
      'glucoseTiming': glucoseTiming.index,
      'activity': activity?.toMap(),
    };
  }
}
