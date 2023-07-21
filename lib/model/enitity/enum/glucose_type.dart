import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum GlucoseTiming { beforeMeal, afterMeal, fasting }

String getPathToIcon(GlucoseTiming glucoseLevelType) {
  switch (glucoseLevelType) {
    case GlucoseTiming.beforeMeal:
      return "assets/svg/before_meal_icon.svg";
    case GlucoseTiming.afterMeal:
      return "assets/svg/after_meal_icon.svg";
    case GlucoseTiming.fasting:
      return "assets/svg/fasting_icon.svg";
    default:
      return "";
  }
}

String getGlucoseLevelTypeTitle(
    GlucoseTiming glucoseLevelType, BuildContext context) {
  switch (glucoseLevelType) {
    case GlucoseTiming.beforeMeal:
      return AppLocalizations.of(context)!.beforeMeal;
    case GlucoseTiming.afterMeal:
      return AppLocalizations.of(context)!.afterMeal;
    case GlucoseTiming.fasting:
      return AppLocalizations.of(context)!.fasting;
    default:
      return " ";
  }
}
