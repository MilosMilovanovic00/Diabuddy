import 'package:diabuddy/model/dto/glucose_entry_dto.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyGlucoseIndicatorContainer extends StatelessWidget {
  const DailyGlucoseIndicatorContainer({
    Key? key,
    required this.glucoseEntryDTO,
  }) : super(key: key);

  final GlucoseEntryDTO glucoseEntryDTO;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 150,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        color: goodSugarColor,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Glucose\n',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 22,
                          ),
                    ),
                    TextSpan(
                      text: 'Meal: ${glucoseEntryDTO.carbonContent} UH\n',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    TextSpan(
                      text: '${glucoseEntryDTO.medicationName}\n',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    TextSpan(
                      text: '${formatDateTime(glucoseEntryDTO.entryTime)}\n',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    //TODO postavi koji konkretno mera treba da bude i konvertuj vrednost
                    TextSpan(
                      text: '${glucoseEntryDTO.glucoseValue} mmol/L',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const ColouredIconButton(
              backgroundColor: goodSugarColor,
              icon: Icon(
                Icons.water_drop,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }
}
