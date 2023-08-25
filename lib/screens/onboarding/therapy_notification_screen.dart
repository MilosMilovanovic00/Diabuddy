import 'package:diabuddy/bloc/notification/notification_bloc.dart';
import 'package:diabuddy/bloc/notification/notification_event.dart';
import 'package:diabuddy/bloc/notification/notification_state.dart';
import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/model/app_notification.dart';
import 'package:diabuddy/model/enitity/enum/notification_type.dart';
import 'package:diabuddy/screens/dashboard/components/notification_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/screens/reusable/small_app_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TherapyNotificationScreen extends StatefulWidget {
  const TherapyNotificationScreen({
    super.key,
    required this.therapyId,
    required this.therapyName,
  });

  final String therapyId;
  final String therapyName;

  @override
  State<TherapyNotificationScreen> createState() =>
      _TherapyNotificationScreenState();
}

class _TherapyNotificationScreenState extends State<TherapyNotificationScreen> {
  late int hour;
  late int minute;

  @override
  void initState() {
    super.initState();
    hour = DateTime.now().hour;
    minute = DateTime.now().minute;
    BlocProvider.of<NotificationBloc>(context)
        .add(GetNotificationsForTherapy(widget.therapyId));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 75,
          toolbarHeight: 70,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              top: 20,
            ),
            child: AppIconButton(
              callback: () {
                BlocProvider.of<UserBloc>(context).add(GetAllMedications());
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        body: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is DeletedNotification) {
              BlocProvider.of<NotificationBloc>(context)
                  .add(GetNotificationsForTherapy(widget.therapyId));
            } else if (state is DeletingNotificationFailed) {
              showSnackBar(
                context,
                AppLocalizations.of(context)!.deletingNotificationFailed,
              );
            } else if (state is SavedNotification) {
              Navigator.pop(context);
              BlocProvider.of<NotificationBloc>(context)
                  .add(GetNotificationsForTherapy(widget.therapyId));
            } else if (state is SavingNotificationFailed) {
              showSnackBar(
                context,
                AppLocalizations.of(context)!.savingNotificationFailed,
              );
            }
          },
          buildWhen: (previous, current) =>
              current is FetchedNotificationsForTherapy,
          builder: (context, state) {
            if (state is! FetchedNotificationsForTherapy) {
              return Container();
            } else {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .setNotificationsForTherapy,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.notifications.length,
                          itemBuilder: (context, index) {
                            return NotificationContainer(
                              appNotification: state.notifications[index],
                              deleteNotification: deleteNotification,
                              medicationName: widget.therapyName,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppButton(
                        callback: () {
                          showNotificationTimePickerDialog(context);
                        },
                        text: AppLocalizations.of(context)!.addNotification,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    ]);
  }

  void setHour(int value) {
    setState(() {
      hour = value;
    });
  }

  void setMinute(int value) {
    setState(() {
      minute = value;
    });
  }

  void showNotificationTimePickerDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          child: Container(
            height: 330,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.setTimeForYourNotification,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 30,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: containerColorGradient,
                        borderRadius: borderRadius,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppNumberPicker(
                            widgetWidth: 50,
                            widgetHeight: 40,
                            axis: Axis.vertical,
                            minValue: 0,
                            currentValue: hour,
                            maxValue: 23,
                            setCurrentValue: setHour,
                          ),
                          AppNumberPicker(
                            widgetWidth: 50,
                            widgetHeight: 40,
                            axis: Axis.vertical,
                            currentValue: minute,
                            minValue: 0,
                            maxValue: 59,
                            setCurrentValue: setMinute,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SmallAppButton(
                        callback: () {
                          Navigator.pop(context);
                        },
                        text: AppLocalizations.of(context)!.cancel,
                        backgroundColor: Colors.white,
                        textColor: primaryColor,
                      ),
                      SmallAppButton(
                          callback: () {
                            addNotification(hour, minute);
                          },
                          text: AppLocalizations.of(context)!.save)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  void addNotification(int hour, int minute) {
    DateTime now = DateTime.now();
    DateTime triggerTime = DateTime(now.year, now.month, now.day, hour, minute);
    AppNotification appNotification = AppNotification(
      triggerTime: triggerTime,
      notificationType: NotificationType.therapy,
      therapyId: widget.therapyId,
    );
    BlocProvider.of<NotificationBloc>(context)
        .add(SaveNotification(appNotification));
  }

  deleteNotification(String notificationId) {
    BlocProvider.of<NotificationBloc>(context)
        .add(DeleteNotification(notificationId));
    //TODO skloni notifikaciju sa okidanja
  }
}
