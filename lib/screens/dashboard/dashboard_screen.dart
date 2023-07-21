import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/dto/glucose_entry_dto.dart';
import 'package:diabuddy/model/dto/medication_dto.dart';
import 'package:diabuddy/model/enitity/enum/time_period_type.dart';
import 'package:diabuddy/screens/dashboard/components/diagram_container.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/screens/reusable/daily_glucose_indicator_container.dart';
import 'package:diabuddy/screens/reusable/daily_medication_indicator_container.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<MedicationDto> medications = [];
  late List<GlucoseEntryDTO> glucoseEntries = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetAllMedications());
    BlocProvider.of<UserBloc>(context).add(GetTodaysGlucoseReadings());
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
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is FetchedMedicationData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.medicine.length,
                          itemBuilder: (context, index) {
                            return DailyMedicationIndicatorContainer(
                              medication: state.medicine[index],
                            );
                          },
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: containerColorGradient,
                            borderRadius: borderRadius,
                          ),
                          child: Center(
                            child: Text(
                              "No registered medication",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        );
                      }
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
                        glucoseEntryDTO: glucoseEntries[index],
                      );
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
