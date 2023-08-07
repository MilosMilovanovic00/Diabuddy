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
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: AppLocalizations.of(context)!.glucose,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 22,
                  ),
            ),
            TextSpan(
              text:
                  '\n${AppLocalizations.of(context)!.mealWithCarbonHydrateValue(glucoseReading.glucoseValue)}',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
            TextSpan(
              text: '\n${glucoseReading.entryTime.getFormattedTime()}\n',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
            TextSpan(
              text:
                  '${glucoseReading.glucoseValue.convertByStandardUnit()} ${isStandardUnit ? 'mmol/L' : 'mg/dl'}',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
