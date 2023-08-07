import 'package:diabuddy/model/enitity/activity.dart';
import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/model/enitity/enum/meal_type.dart';
import 'package:equatable/equatable.dart';

class GlucoseReading extends Equatable {
  final String? id;
  final DateTime entryTime;
  final GlucoseTiming glucoseTiming;
  final double glucoseValue;
  final MealType? mealType;
  final Activity? activity;
  final bool medicationTaken;
  final bool mealTaken;

  const GlucoseReading({
    this.id,
    required this.entryTime,
    required this.glucoseValue,
    required this.glucoseTiming,
    this.mealType,
    this.activity,
    required this.medicationTaken,
    required this.mealTaken,
  });

  @override
  List<Object?> get props => [
        entryTime,
        glucoseValue,
        glucoseTiming,
        mealType,
        activity,
        medicationTaken,
        mealTaken,
      ];

  factory GlucoseReading.fromMap(map, String id) {
    return GlucoseReading(
      id: id,
      entryTime: map['entryTime'].toDate(),
      glucoseTiming: GlucoseTiming.values[map['glucoseTiming']],
      glucoseValue: map['glucoseValue'],
      mealType:
          map['mealType'] != null ? MealType.values[map['mealType']] : null,
      activity: Activity.fromMap(map['activity']),
      medicationTaken: map['medicationTaken'],
      mealTaken: map['mealType'] != null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'entryTime': entryTime,
      'glucoseTiming': glucoseTiming,
      'glucoseValue': glucoseValue,
      'mealType': mealType?.index,
      'activity': activity?.toMap(),
      'medicationTaken': medicationTaken,
      'mealTaken': mealType != null,
    };
  }
}
