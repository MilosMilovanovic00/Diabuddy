import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? preference;

  static Future init() async =>
      preference = await SharedPreferences.getInstance();

  static Future setMeasurementUnit(bool isStandardUnit) async {
    preference?.setBool('isStandardUnit', isStandardUnit);
  }

  static getMeasurementUnit() {
    return preference!.get('isStandardUnit');
  }

  static Future setLanguagePreferences(bool isEnglish) async {
    preference?.setBool('isEnglish', isEnglish);
  }

  static getLanguagePreferences() {
    return preference!.get('isEnglish');
  }
}
