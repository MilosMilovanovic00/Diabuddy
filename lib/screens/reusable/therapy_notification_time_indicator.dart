import 'package:diabuddy/model/enitity/app_notification.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TherapyNotificationTimeIndicator extends StatelessWidget {
  const TherapyNotificationTimeIndicator({
    Key? key,
    required this.backgroundColor,
    required this.appNotification,
    required this.removeNotification,
  }) : super(key: key);

  final Color backgroundColor;
  final AppNotification appNotification;
  final Function(AppNotification) removeNotification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                appNotification.triggerTime.toString().substring(10,15),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  removeNotification(appNotification);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }
}
