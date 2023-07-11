import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/model/enitity/app_notification.dart';
import 'package:diabuddy/model/enitity/enum/notification_type.dart';
import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/screens/reusable/small_app_button.dart';
import 'package:diabuddy/screens/reusable/therapy_notification_time_indicator.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MedicationContainer extends StatefulWidget {
  const MedicationContainer({
    Key? key,
    required this.medication,
  }) : super(key: key);

  final Medication medication;

  @override
  State<MedicationContainer> createState() => _MedicationContainerState();
}

class _MedicationContainerState extends State<MedicationContainer> {
  List<AppNotification> list = [
    AppNotification(
        triggerTime: TimeOfDay.now(), type: NotificationType.activity),
    AppNotification(
        triggerTime: TimeOfDay.now(), type: NotificationType.insulin),
    AppNotification(
        triggerTime: TimeOfDay.now(), type: NotificationType.glucose),
    AppNotification(
        triggerTime: TimeOfDay.now(), type: NotificationType.activity),
  ];

  late int hour;
  late int minute;

  @override
  void initState() {
    super.initState();
    hour = DateTime.now().hour;
    minute = DateTime.now().minute;
  }

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
            horizontal: 10.0,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.medication.medicationName!,
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  ColouredIconButton(
                    callback: () => showCustomDialog(context),
                    backgroundColor: primaryColor,
                    icon: const Icon(
                      Icons.notification_add_sharp,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ColouredIconButton(
                    callback: () {
                      BlocProvider.of<UserBloc>(context).add(
                        DeleteMedication(
                          medicationId: widget.medication.medicationId!,
                        ),
                      );
                    },
                    backgroundColor: primaryColor,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.dailyIntake}: ${widget.medication.dailyMedicationIntake}',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  Text(
                    widget.medication.isInsulin!
                        ? '${AppLocalizations.of(context)!.units}: ${widget.medication.averageInsulinUnits}'
                        : '',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      widget.medication.isInsulin!
                          ? './assets/svg/syringe_icon.svg'
                          : './assets/svg/pills_icon.svg',
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      TherapyNotificationTimeIndicator(
                    backgroundColor: primaryColor,
                    appNotification: list[index],
                    removeNotification: removeNotification,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void removeNotification(AppNotification dateTime) {
    setState(() {
      list.remove(dateTime);
    });
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

  void showCustomDialog(BuildContext context) => showDialog(
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
    AppNotification appNotification = AppNotification(
      triggerTime: TimeOfDay(hour: hour, minute: minute),
      type: NotificationType.insulin,
    );
    setState(() {
      list.add(appNotification);
    });
  }
}
