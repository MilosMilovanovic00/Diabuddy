import 'package:diabuddy/model/app_notification.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {}

class InitialNotificationState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class SavedNotification extends NotificationState {
  @override
  List<Object?> get props => [];
}

class SavingNotificationFailed extends NotificationState {
  @override
  List<Object?> get props => [];
}

class DeletedNotification extends NotificationState {
  @override
  List<Object?> get props => [];
}

class DeletingNotificationFailed extends NotificationState {
  @override
  List<Object?> get props => [];
}

class FetchedNotifications extends NotificationState {
  final List<AppNotification> notifications;

  FetchedNotifications(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class FetchingNotificationsFailed extends NotificationState {
  @override
  List<Object?> get props => [];
}

class FetchedNotificationsForTherapy extends NotificationState {
  final List<AppNotification> notifications;

  FetchedNotificationsForTherapy(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class FetchingNotificationsFailedForTherapy extends NotificationState {
  @override
  List<Object?> get props => [];
}
