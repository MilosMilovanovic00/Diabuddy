import 'package:diabuddy/model/app_notification.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {}

class SaveNotification extends NotificationEvent {
  final AppNotification notification;

  SaveNotification(this.notification);

  @override
  List<Object?> get props => [notification];
}

class DeleteNotification extends NotificationEvent {
  final String notificationId;

  DeleteNotification(this.notificationId);

  @override
  List<Object?> get props => [];
}

class GetNotifications extends NotificationEvent {
  @override
  List<Object?> get props => [];
}

class GetNotificationsForTherapy extends NotificationEvent {
  final String therapyId;

  GetNotificationsForTherapy(this.therapyId);

  @override
  List<Object?> get props => [];
}
