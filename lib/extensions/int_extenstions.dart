import 'package:diabuddy/preferences/user_simple_preferences.dart';

extension IntExtension on int {
  int convertByStandardUnit() {
    bool isStandardUnit = UserSimplePreferences.isStandardMeasurementUnit();
    return isStandardUnit ? this : (this * 18);
  }
}
