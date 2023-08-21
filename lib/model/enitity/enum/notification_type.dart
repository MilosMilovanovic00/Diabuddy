import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum NotificationType { activity, therapy, glucose }

String getNotificationType(NotificationType type, BuildContext context) {
  switch (type) {
    case NotificationType.activity:
      return AppLocalizations.of(context)!.activityReminder;
    case NotificationType.therapy:
      return AppLocalizations.of(context)!.therapyReminder;
    case NotificationType.glucose:
      return AppLocalizations.of(context)!.glucoseCheckReminder;
  }
}

List<NotificationType> getAllNotificationTypes() {
  return List.of([
    NotificationType.activity,
    NotificationType.glucose,
  ]);
}