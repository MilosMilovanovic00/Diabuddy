import 'package:diabuddy/extensions/datetime_extensinons.dart';
import 'package:diabuddy/extensions/double_extensions.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DailyGlucoseIndicatorContainer extends StatelessWidget {
  const DailyGlucoseIndicatorContainer({
    Key? key,
    required this.glucoseReading,
  }) : super(key: key);

  final GlucoseReading glucoseReading;

  @override
  Widget build(BuildContext context) {
    final bool isStandardUnit =
        UserSimplePreferences.isStandardMeasurementUnit();
    final Color backColor =
        glucoseReading.glucoseValue.getColorByGlucoseLevel();
    return Container(
      width: 180,
      height: 150,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildText(context, isStandardUnit),
            ColouredIconButton(
              backgroundColor: backColor,
              icon: const Icon(
                Icons.water_drop,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildText(BuildContext context, bool isStandardUnit) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.glucose,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 24,
                ),
          ),
          Visibility(
            visible: glucoseReading.mealTaken,
            child: Text(
              AppLocalizations.of(context)!.mealTaken,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
          Visibility(
            visible: glucoseReading.medicationTaken,
            child: Text(
              AppLocalizations.of(context)!.medicationTaken,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
          Visibility(
            visible: glucoseReading.activity != null,
            child: Text(
              AppLocalizations.of(context)!
                  .activityWithValue(glucoseReading.activity?.name),
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
          Text(
            glucoseReading.entryTime.getFormattedTime(),
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 18,
                ),
          ),
          Text(
            '${glucoseReading.glucoseValue.convertByStandardUnit()} ${isStandardUnit ? 'mmol/L' : 'mg/dl'}',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 21,
                ),
          ),
        ],
      ),
    );
  }
}
