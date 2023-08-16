import 'package:diabuddy/extensions/string_extenstions.dart';
import 'package:diabuddy/model/enitity/activity.dart';
import 'package:diabuddy/model/enitity/enum/activity_type.dart';
import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/glucose_time_choice_picker.dart';
import 'package:diabuddy/screens/onboarding/components/simple_app_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_dropdown_container.dart';
import 'package:diabuddy/screens/reusable/app_number_input_field.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/app_text_field_input.dart';
import 'package:diabuddy/screens/reusable/small_app_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showCustomDialog(
  BuildContext context,
) =>
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.setTimeForYourNotification,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 30,
                    ),
              ),
              SimpleAppContainer(
                fontSize: 18,
                text: AppLocalizations.of(context)!.setTimeForYourNotification,
                widget: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

void showGlucoseValueAndTimingDialog(
  BuildContext context,
  TextEditingController glucoseValueController,
  GlucoseTiming glucoseTiming,
  Function setGlucoseTiming,
  Function setGlucoseValue,
) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: const BorderSide(
          width: 5,
          color: primaryColor,
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 520,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 15,
          ),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.setGlucoseEntryParameters,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 25,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppNumberInputField(
                text: AppLocalizations.of(context)!.glucoseLevel,
                containerColor: primaryColor,
                controller: glucoseValueController,
                initialValue: glucoseValueController.text,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: primaryColor,
                      width: 5,
                    )),
                child: GlucoseTimeChoicePicker(
                  type: glucoseTiming,
                  setGlucoseTiming: setGlucoseTiming,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                callback: () {
                  String value = glucoseValueController.text.trim();
                  if (value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('You must fill the field')),
                    );
                  } else if (!value.isDoubleNumber()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('You must enter number')),
                    );
                  } else {
                    setGlucoseValue(double.parse(value));
                    Navigator.pop(context);
                  }
                },
                text: AppLocalizations.of(context)!.save,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void showActivityDialog(
  BuildContext context,
  TextEditingController activityNameController,
  int duration,
  Function(dynamic) setActivityType,
  Function setDuration,
  ActivityIntensity intensity,
  Function setActivity,
) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.white,
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
              AppLocalizations.of(context)!.addYourActivity,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: formKey,
              child: AppTextFieldInput(
                hintText: AppLocalizations.of(context)!.activityName,
                controller: activityNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You must enter activity name';
                  }
                  return null;
                },
                textInputType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.7),
                borderRadius: borderRadius,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.activityIntensity,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: borderRadius,
                        boxShadow: [simpleBoxShadow],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.7),
                            borderRadius: borderRadius),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AppDropdownContainer(
                            choice: intensity,
                            setChoice: setActivityType,
                            choices: getAllActivityTypes(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SimpleAppContainer(
              text: AppLocalizations.of(context)!.activityDuration,
              widget: AppNumberPicker(
                minValue: 10,
                step: 10,
                maxValue: 240,
                currentValue: duration,
                setCurrentValue: setDuration,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallAppButton(
                  backgroundColor: Colors.white,
                  textColor: primaryColor,
                  callback: () {
                    Navigator.pop(context);
                  },
                  text: AppLocalizations.of(context)!.cancel,
                ),
                SmallAppButton(
                  callback: () {
                    if (formKey.currentState!.validate()) {
                      Activity activity = Activity(
                        name: activityNameController.text.trim(),
                        intensity: intensity,
                        duration: duration,
                      );
                      setActivity(activity);
                      Navigator.pop(context);
                    }
                  },
                  text: AppLocalizations.of(context)!.add,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
