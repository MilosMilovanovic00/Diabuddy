import 'package:diabuddy/model/dto/glucose_entry_dto.dart';
import 'package:diabuddy/model/dto/medication_dto.dart';
import 'package:diabuddy/model/enitity/enum/time_period_type.dart';
import 'package:diabuddy/screens/dashboard/components/diagram_container.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/screens/reusable/daily_glucose_indicator_container.dart';
import 'package:diabuddy/screens/reusable/daily_medication_indicator_container.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MedicationDto> medications = [
      MedicationDto(
          dailyIntake: 4,
          insulinUnits: 6,
          isInsulin: true,
          medicationName: 'Novolin R FlexPen ReliOn'),
      MedicationDto(
          dailyIntake: 4,
          insulinUnits: 6,
          isInsulin: true,
          medicationName: 'NovoRapid'),
      MedicationDto(
          dailyIntake: 4,
          insulinUnits: 6,
          isInsulin: true,
          medicationName: 'NovoRapid'),
    ];
    final List<GlucoseEntryDTO> glucoseEntries = [
      GlucoseEntryDTO(
        medicationName: 'Novolin R FlexPen ReliOn',
        entryTime: DateTime.now(),
        glucoseValue: 5.6,
        mealIntake: 45,
      ),
      GlucoseEntryDTO(
        medicationName: 'NovoRapid',
        entryTime: DateTime.now(),
        glucoseValue: 2.5,
        mealIntake: 45,
      ),
      GlucoseEntryDTO(
        medicationName: 'Tresiba',
        entryTime: DateTime.now(),
        glucoseValue: 15.6,
        mealIntake: 45,
      ),
    ];

    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Diabuddy',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
                    ),
              ),
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        bottomNavigationBar: const AppBottomNavigationBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: medications.length,
                    itemBuilder: (context, index) {
                      return DailyMedicationIndicatorContainer(
                        medication: medications[index],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: glucoseEntries.length,
                    itemBuilder: (context, index) {
                      return DailyGlucoseIndicatorContainer(
                          glucoseEntryDTO: glucoseEntries[index]);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: DiagramContainer(
                    backgroundColor: orangeColor.withOpacity(0.8),
                    diagramTitle: AppLocalizations.of(context)!.glucoseDiagram,
                    isDiagramScreen: false,
                    toolTipColor: orangeColor,
                    timePeriodType: TimePeriodType.today,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
