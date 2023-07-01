import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum GlucoseTimeType { beforeMeal, afterMeal, fasting }

String getPathToIcon(GlucoseTimeType glucoseLevelType) {
  switch (glucoseLevelType) {
    case GlucoseTimeType.beforeMeal:
      return "assets/svg/before_meal_icon.svg";
    case GlucoseTimeType.afterMeal:
      return "assets/svg/after_meal_icon.svg";
    case GlucoseTimeType.fasting:
      return "assets/svg/fasting_icon.svg";
    default:
      return "";
  }
}

String getGlucoseLevelTypeTitle(
    GlucoseTimeType glucoseLevelType, BuildContext context) {
  switch (glucoseLevelType) {
    case GlucoseTimeType.beforeMeal:
      return AppLocalizations.of(context)!.beforeMeal;
    case GlucoseTimeType.afterMeal:
      return AppLocalizations.of(context)!.afterMeal;
    case GlucoseTimeType.fasting:
      return AppLocalizations.of(context)!.fasting;
    default:
      return " ";
  }
}
