import 'package:diabuddy/extensions/datetime_extensinons.dart';
import 'package:diabuddy/extensions/double_extensions.dart';
import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/screens/glucose_monitoring/glucose_entry_screen.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlucoseEntryContainer extends StatelessWidget {
  const GlucoseEntryContainer({
    Key? key,
    required this.glucoseReading,
  }) : super(key: key);

  final GlucoseReading glucoseReading;

  @override
  Widget build(BuildContext context) {
    bool isStandardUnit = UserSimplePreferences.isStandardMeasurementUnit();
    final Color backColor =
        glucoseReading.glucoseValue.getColorByGlucoseLevel();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GlucoseEntryScreen(
              glucoseReadingId: glucoseReading.id!,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: backColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 22,
                        ),
                    children: [
                      TextSpan(
                          text:
                              '${glucoseReading.glucoseValue.convertByStandardUnit()} '),
                      TextSpan(
                        text: '${isStandardUnit ? 'mmol/L' : 'mg/dl'}\n',
                      ),
                      TextSpan(
                        text: glucoseReading.entryTime.getFormattedTime(),
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 16,
                                ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ColouredIconButton(
                      backgroundColor: backColor,
                      icon: const Icon(
                        Icons.directions_run_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ColouredIconButton(
                      backgroundColor: backColor,
                      icon: const Icon(
                        Icons.flatware_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ColouredIconButton(
                      backgroundColor: backColor,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          './assets/svg/medicine.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ColouredIconButton(
                      backgroundColor: backColor,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          getGlucoseTimingPathToIcon(
                            glucoseReading.glucoseTiming,
                          ),
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
