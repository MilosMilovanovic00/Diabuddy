import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';

extension DoubleExtension on double {
  double convertByStandardUnit() {
    bool isStandardUnit = UserSimplePreferences.isStandardMeasurementUnit();
    return isStandardUnit ? this : (this * 18);
  }

  double transformToStandardUnit() {
    bool isStandardUnit = UserSimplePreferences.isStandardMeasurementUnit();
    return isStandardUnit ? this : (this / 18);
  }

  Color getColorByGlucoseLevel() {
    double lowSugar = UserSimplePreferences.getLowGlucoseValue();
    double highSugar = UserSimplePreferences.getHighGlucoseValue();
    if (this < lowSugar) {
      return lowSugarColor;
    } else if (this < highSugar) {
      return goodSugarColor;
    }
    return highSugarColor;
  }
}
