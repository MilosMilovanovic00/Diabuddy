import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ActivityIntensity { light, intense, moderate }

String getStringForActivityIntensity(
    ActivityIntensity? activityIntensity, BuildContext context) {
  if (activityIntensity == null) {
    return '';
  }
  switch (activityIntensity) {
    case ActivityIntensity.light:
      return AppLocalizations.of(context)!.light;
    case ActivityIntensity.intense:
      return AppLocalizations.of(context)!.intense;
    case ActivityIntensity.moderate:
      return AppLocalizations.of(context)!.moderate;
  }
}

List<String> getActivityValues(BuildContext context) {
  return List.of([
    AppLocalizations.of(context)!.light,
    AppLocalizations.of(context)!.moderate,
    AppLocalizations.of(context)!.intense
  ]);
}

List<ActivityIntensity> getAllActivityTypes() {
  return List.of([
    ActivityIntensity.light,
    ActivityIntensity.intense,
    ActivityIntensity.moderate,
  ]);
}
