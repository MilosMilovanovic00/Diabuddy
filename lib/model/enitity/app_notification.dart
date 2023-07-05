import 'package:diabuddy/model/enitity/enum/notification_type.dart';

class AppNotification {
  AppNotification({required this.triggerTime, required this.type});

  final DateTime triggerTime;
  final NotificationType type;
}
