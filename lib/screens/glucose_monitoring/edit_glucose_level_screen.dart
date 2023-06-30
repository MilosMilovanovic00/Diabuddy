import 'package:diabuddy/model/enitity/glucose_type.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/glucose_time_choice_picker.dart';
import 'package:diabuddy/screens/onboarding/simple_app_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGlucoseLevelScreen extends StatefulWidget {
  const EditGlucoseLevelScreen({
    Key? key,
    this.glucoseLevel,
    this.glucoseLevelType,
  }) : super(key: key);

  final double? glucoseLevel;
  final GlucoseTimeType? glucoseLevelType;

  @override
  State<EditGlucoseLevelScreen> createState() => _EditGlucoseLevelScreenState();
}

class _EditGlucoseLevelScreenState extends State<EditGlucoseLevelScreen> {
  late int glucoseLevelFirstDigit;
  late int glucoseLevelSecondDigit;
  late GlucoseTimeType? glucoseType;

  @override
  void initState() {
    super.initState();
    glucoseLevelFirstDigit = widget.glucoseLevel?.toInt() ?? 5;
    if (widget.glucoseLevel != null) {
      glucoseLevelSecondDigit =
          ((widget.glucoseLevel! - glucoseLevelFirstDigit) * 10).toInt();
    } else {
      glucoseLevelSecondDigit = 0;
    }
    glucoseType = widget.glucoseLevelType;
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
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
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
                  'Edit glucose level',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                SimpleAppContainer(
                  text: 'Glucose level',
                  widget: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          maxValue: 30,
                          currentValue: glucoseLevelFirstDigit,
                          setCurrentValue: setFirstDigit,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '.',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        AppNumberPicker(
                          axis: Axis.vertical,
                          widgetHeight: 40,
                          widgetWidth: 40,
                          selectedTextSize: 20,
                          unselectedTextSize: 14,
                          minValue: 0,
                          maxValue: 9,
                          currentValue: glucoseLevelSecondDigit,
                          setCurrentValue: setSecondDigit,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GlucoseTimeChoicePicker(),
                const Spacer(),
                AppButton(
                  callback: () {},
                  text: AppLocalizations.of(context)!.save,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  void setFirstDigit(int value) {
    setState(() {
      glucoseLevelFirstDigit = value;
    });
  }

  void setSecondDigit(int value) {
    setState(() {
      glucoseLevelSecondDigit = value;
    });
  }
}
