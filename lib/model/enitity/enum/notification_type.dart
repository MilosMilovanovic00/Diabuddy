import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum NotificationType { activity, insulin, glucose }

String getNotificationType(BuildContext context, NotificationType type) {
  switch (type) {
    case NotificationType.activity:
      return AppLocalizations.of(context)!.activityReminder;
    case NotificationType.insulin:
      return AppLocalizations.of(context)!.insulinReminder;
    case NotificationType.glucose:
      return AppLocalizations.of(context)!.glucoseCheckReminder;
  }
}
