import 'package:diabuddy/screens/onboarding/simple_app_container.dart';
import 'package:diabuddy/screens/onboarding/units_onboarding_screen.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileOnboardingScreen extends StatefulWidget {
  const ProfileOnboardingScreen({
    Key? key,
    this.weight,
  }) : super(key: key);
  final int? weight;

  @override
  State<ProfileOnboardingScreen> createState() =>
      _ProfileOnboardingScreenState();
}

class _ProfileOnboardingScreenState extends State<ProfileOnboardingScreen> {
  late int weight;
  late int day;
  late int month;
  late int maxDays;
  late int year;

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
            icon: Icons.close,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.profileOnboardingTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.profileOnboardingBodyText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              SimpleAppContainer(
                text: AppLocalizations.of(context)!.weight,
                widget: AppNumberPicker(
                  minValue: 0,
                  maxValue: 100,
                  setCurrentValue: setWeight,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SimpleAppContainer(
                text: AppLocalizations.of(context)!.dateOfBirth,
                widget: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      AppNumberPicker(
                        axis: Axis.vertical,
                        widgetHeight: 40,
                        widgetWidth: 40,
                        selectedTextSize: 20,
                        unselectedTextSize: 14,
                        minValue: 1,
                        maxValue: 31,
                        currentValue: day,
                        setCurrentValue: setDay,
                      ),
                      const Spacer(),
                      AppNumberPicker(
                        axis: Axis.vertical,
                        widgetHeight: 40,
                        widgetWidth: 40,
                        selectedTextSize: 20,
                        unselectedTextSize: 14,
                        minValue: 1,
                        maxValue: 12,
                        currentValue: month,
                        setCurrentValue: setMonth,
                      ),
                      const Spacer(),
                      AppNumberPicker(
                        axis: Axis.vertical,
                        widgetHeight: 40,
                        widgetWidth: 70,
                        selectedTextSize: 20,
                        unselectedTextSize: 14,
                        minValue: 1900,
                        maxValue: year,
                        currentValue: 2000,
                        setCurrentValue: setYear,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              AppButton(
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UnitsOnboardingScreen(),
                    ),
                  );
                },
                text: AppLocalizations.of(context)!.save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setWeight(int value) {
    weight = value;
  }

  void setDay(int value) {
    day = value;
  }

  void setMonth(int value) {
    month = value;
  }

  void setYear(int value) {
    year = value;
  }

  @override
  void initState() {
    super.initState();
    weight = widget.weight ?? 45;
    day = DateTime.now().day;
    month = DateTime.now().month;
    year = DateTime.now().year;
    maxDays = evalMaxDays(month);
    maxDays = isLeapYear(year) ? maxDays + 1 : maxDays;
  }

  int evalMaxDays(int month) {
    if (month < 8) {
      if (month % 2 != 0) {
        return 31;
      } else if (month != 2) {
        return 30;
      } else {
        return 28;
      }
    } else {
      if (month % 2 != 0) {
        return 30;
      } else {
        return 31;
      }
    }
  }

  bool isLeapYear(int year) {
    if (year % 4 != 0) {
      return false;
    } else if (year % 100 != 0) {
      return true;
    } else if (year % 400 != 0) {
      return false;
    } else {
      return true;
    }
  }
}
