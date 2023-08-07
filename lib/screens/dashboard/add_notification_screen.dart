import 'package:diabuddy/model/enitity/enum/notification_type.dart';
import 'package:diabuddy/screens/onboarding/components/simple_app_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_dropdown_container.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({
    Key? key,
    this.minute,
    this.hour,
    this.notificationType,
  }) : super(key: key);

  final int? minute;
  final int? hour;
  final NotificationType? notificationType;

  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
  late int minute;
  late int hour;
  late NotificationType notificationChoice;

  @override
  void initState() {
    super.initState();
    minute = widget.minute ?? 0;
    hour = widget.hour ?? 12;
    notificationChoice = widget.notificationType ?? NotificationType.activity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              Navigator.pop(context);
            },
            icon: Icons.arrow_back_ios_new,
          ),
        ),
      ),
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
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 28),
              ),
              const SizedBox(
                height: 40,
              ),
              SimpleAppContainer(
                fontSize: 18,
                text: AppLocalizations.of(context)!.setTimeForYourNotification,
                widget: Expanded(
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: containerColorGradient,
                  borderRadius: borderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.notificationType,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AppDropdownContainer(
                          setChoice: setChoice,
                          choices: getAllNotificationTypes(),
                          choice: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              AppButton(
                callback: () {},
                text: AppLocalizations.of(context)!.save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setHour(int value) {
    setState(() {});
  }

  void setMinute(int value) {
    setState(() {});
  }

  void setChoice(dynamic type) {
    setState(() {});
  }
}
