import 'package:diabuddy/bloc/notification/notification_bloc.dart';
import 'package:diabuddy/bloc/notification/notification_event.dart';
import 'package:diabuddy/bloc/notification/notification_state.dart';
import 'package:diabuddy/screens/dashboard/add_notification_screen.dart';
import 'package:diabuddy/screens/dashboard/components/notification_container.dart';
import 'package:diabuddy/screens/reusable/app_add_button.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationBloc>(context).add(GetNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Scaffold(
          backgroundColor: primaryColor.withOpacity(0.10),
          bottomNavigationBar: const AppBottomNavigationBar(
            selectedIndex: 4,
          ),
          body: BlocListener<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state is DeletedNotification) {
                BlocProvider.of<NotificationBloc>(context)
                    .add(GetNotifications());
              } else {
                showSnackBar(
                  context,
                  AppLocalizations.of(context)!.deletingNotificationFailed,
                );
              }
            },
            child: SafeArea(
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
                      callback: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddNotificationScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<NotificationBloc, NotificationState>(
                      builder: (context, state) {
                        if (state is FetchedNotifications) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state.notifications.length,
                              itemBuilder: (context, index) {
                                return NotificationContainer(
                                  appNotification: state.notifications[index],
                                  deleteNotification: deleteNotification,
                                );
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  deleteNotification(String notificationId) {
    //prekini notifikacije
    BlocProvider.of<NotificationBloc>(context)
        .add(DeleteNotification(notificationId));
  }
}
