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
      activity:
          map['activity'] != null ? Activity.fromMap(map['activity']) : null,
      medicationTaken: map['medicationTaken'],
      mealTaken:
          map['mealTaken'] ?? map['mealType'] != null,
    );
  }

  Map<String, dynamic> toMap() {
    var data = {
      'entryTime': entryTime,
      'glucoseTiming': glucoseTiming.index,
      'glucoseValue': glucoseValue,
      'medicationTaken': medicationTaken,
      'mealTaken': glucoseTiming != GlucoseTiming.fasting,
    };
    if (activity != null) {
      data['activity'] = activity!.toMap();
    }
    if (mealType != null) {
      data['mealType'] = mealType!.index;
    }
    return data;
  }
}
