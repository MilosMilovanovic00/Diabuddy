import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/extensions/datetime_extensinons.dart';
import 'package:diabuddy/model/enitity/enum/time_period_type.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/screens/dashboard/components/diagram_container.dart';
import 'package:diabuddy/screens/dashboard/components/time_period_selector.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiagramScreen extends StatefulWidget {
  const DiagramScreen({Key? key}) : super(key: key);

  @override
  State<DiagramScreen> createState() => _DiagramScreenState();
}

class _DiagramScreenState extends State<DiagramScreen> {
  late TimePeriodType timePeriodType = TimePeriodType.today;
  final bool isStandardUnit = UserSimplePreferences.isStandardMeasurementUnit();

  @override
  void initState() {
    super.initState();
    DateTime start = DateTime.now();
    start = DateTime(start.year, start.month, start.day);
    DateTime end = start.add(const Duration(days: 1));
    end = DateTime(end.year, end.month, end.day);
    BlocProvider.of<UserBloc>(context)
        .add(GetGlucoseReadingsForPeriod(start, end));
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
                AppLocalizations.of(context)!.diagrams,
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
        bottomNavigationBar: const AppBottomNavigationBar(
          selectedIndex: 2,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20,
            ),
            child: BlocBuilder<UserBloc, UserState>(
              buildWhen: (previous, current) =>
                  current is FetchedTodayGlucoseReadingsSuccess,
              builder: (context, state) {
                if (state is FetchedTodayGlucoseReadingsSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      TimePeriodSelector(
                        callback: setTimePeriod,
                        timePeriodType: timePeriodType,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.7),
                          borderRadius: borderRadius,
                        ),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.averageBloodGlucose,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 22),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${calculateAverageGlucoseValue(state.readings).toStringAsFixed(2)} ${isStandardUnit ? 'mmol/L' : 'mg/dl'}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 34,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: DiagramContainer(
                          backgroundColor: primaryColor.withOpacity(0.7),
                          diagramTitle: getDiagramByTimePeriodType(
                              context, timePeriodType),
                          isDiagramScreen: true,
                          toolTipColor: primaryColor,
                          timePeriodType: timePeriodType,
                          readings: state.readings,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    ]);
  }

  void setTimePeriod(TimePeriodType type) {
    setState(() {
      timePeriodType = type;
    });
    DateTime start;
    DateTime end;
    DateTime now = DateTime.now();

    switch (timePeriodType) {
      case TimePeriodType.today:
        start = DateTime(now.year,now.month,now.day);
        end = start.add(const Duration(days: 1));
        break;
      case TimePeriodType.week:
        start = DateTime.now().getStartOfWeek();
        end = start.add(const Duration(days: 7));
        end = DateTime(end.year, end.month, end.day);
        break;
      case TimePeriodType.month:
        start = DateTime.now().getStartOfMonth();
        end = start.getEndOfMonth();
        break;
    }
    BlocProvider.of<UserBloc>(context)
        .add(GetGlucoseReadingsForPeriod(start, end));
  }

  double calculateAverageGlucoseValue(List<GlucoseReading> readings) {
    double value = 0;
    for (var element in readings) {
      value += element.glucoseValue;
    }
    return readings.isEmpty ? 0 : value / readings.length;
  }
}
