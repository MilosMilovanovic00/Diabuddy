import 'package:diabuddy/extensions/datetime_extensinons.dart';
import 'package:diabuddy/model/app_notification.dart';
import 'package:diabuddy/model/enitity/enum/notification_type.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    Key? key,
    required this.appNotification,
    required this.deleteNotification,
    this.medicationName,
  }) : super(key: key);

  final AppNotification appNotification;
  final Function deleteNotification;
  final String? medicationName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: containerColorGradient,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 22,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: medicationName != null,
                    child: Text(
                      '$medicationName',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: getNotificationType(
                              appNotification.notificationType, context),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        TextSpan(
                          text:
                              '\n${appNotification.triggerTime.getFormattedTime()}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ColouredIconButton(
                callback: () {
                  deleteNotification(appNotification.id);
                },
                backgroundColor: primaryColor,
                icon: const Icon(
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
}
