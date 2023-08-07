import 'package:diabuddy/model/enitity/app_notification.dart';
import 'package:diabuddy/model/enitity/enum/notification_type.dart';
import 'package:diabuddy/screens/dashboard/components/notification_container.dart';
import 'package:diabuddy/screens/reusable/app_add_button.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AppNotification> notifications = [
      AppNotification(
          triggerTime: TimeOfDay.now(), type: NotificationType.activity),
      AppNotification(
          triggerTime: TimeOfDay.now(), type: NotificationType.glucose),
      AppNotification(
          triggerTime: TimeOfDay.now(), type: NotificationType.insulin),
    ];

    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Scaffold(
          backgroundColor: primaryColor.withOpacity(0.10),
          bottomNavigationBar: AppBottomNavigationBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.notificationScreenTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.notificationScreenSubtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppAddButton(
                    text: AppLocalizations.of(context)!.addNotification,
                    callback: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationContainer(
                          appNotification: notifications[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // AppButton(
                  //   callback: () {},
                  //   text: AppLocalizations.of(context)!.save,
                  // ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
