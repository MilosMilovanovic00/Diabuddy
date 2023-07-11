import 'package:diabuddy/model/enitity/enum/notification_type.dart';
import 'package:flutter/material.dart';

class AppNotification {
  AppNotification({required this.triggerTime, required this.type});

  final TimeOfDay triggerTime;
  final NotificationType type;
}
