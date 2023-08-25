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

String getNotificationTitle(NotificationType type) {
  switch (type) {
    case NotificationType.activity:
      return "Activity reminder";
    case NotificationType.therapy:
      return "Therapy reminder";
    case NotificationType.glucose:
      return "Measure glucose reminder";
  }
}

String getNotificationBody(NotificationType type) {
  switch (type) {
    case NotificationType.activity:
      return "Move, thrive, conquer, repeat.";
    case NotificationType.therapy:
      return "Embrace healing, find strength.";
    case NotificationType.glucose:
      return "Monitor, stay healthy.";
  }
}
