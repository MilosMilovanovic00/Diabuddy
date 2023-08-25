import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? preference;

  static Future init() async =>
      preference = await SharedPreferences.getInstance();

  static Future setMeasurementUnit(bool isStandardUnit) async {
    preference?.setBool('isStandardUnit', isStandardUnit);
  }

  static isStandardMeasurementUnit() {
    return preference!.get('isStandardUnit');
  }

  static Future setLanguagePreferences(bool isEnglish) async {
    preference?.setBool('isEnglish', isEnglish);
  }

  static getLanguagePreferences() {
    return preference!.get('isEnglish');
  }

  static Future setOnboardingScreenSkip(bool skipOnboarding) async {
    preference?.setBool('skipOnboarding', skipOnboarding);
  }

  static getOnboardingScreenSkip() {
    return preference!.get('skipOnboarding');
  }

  static Future setLowGlucoseValue(double value) async {
    preference?.setDouble('lowGlucose', value);
  }

  static getLowGlucoseValue() {
    return preference!.get('lowGlucose');
  }

  static Future setHighGlucoseValue(double value) async {
    preference?.setDouble('highGlucose', value);
  }

  static getHighGlucoseValue() {
    return preference!.get('highGlucose');
  }
}
