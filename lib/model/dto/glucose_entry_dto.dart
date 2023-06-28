import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';

class GlucoseEntryDTO {
  GlucoseEntryDTO({
    required this.medicationName,
    required this.entryTime,
    required this.glucoseValue,
    required this.mealIntake,
  });

  final DateTime entryTime;
  final double glucoseValue;
  final int mealIntake;
  final String medicationName;

  Color evalColor() {
    if (glucoseValue >= 15.4) {
      return highSugarColor;
    } else if (glucoseValue >= 3.9) {
      return goodSugarColor;
    } else {
      return lowSugarColor;
    }
  }
}
