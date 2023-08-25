import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum TimePeriodType { today, week, month }

String getTimePeriodType(BuildContext context, TimePeriodType timePeriodType) {
  switch (timePeriodType) {
    case TimePeriodType.today:
      return AppLocalizations.of(context)!.today;
    case TimePeriodType.week:
      return AppLocalizations.of(context)!.week;
    case TimePeriodType.month:
      return AppLocalizations.of(context)!.month;
  }
}

String getDiagramByTimePeriodType(
    BuildContext context, TimePeriodType timePeriodType) {
  switch (timePeriodType) {
    case TimePeriodType.today:
      return AppLocalizations.of(context)!.todayGlucoseLevels;
    case TimePeriodType.week:
      return AppLocalizations.of(context)!.weekGlucoseLevels;
    case TimePeriodType.month:
      return AppLocalizations.of(context)!.monthGlucoseLevels;
  }
}
