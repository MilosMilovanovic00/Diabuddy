import 'package:diabuddy/extensions/datetime_extensinons.dart';
import 'package:diabuddy/model/enitity/bar_chart_column_values.dart';
import 'package:diabuddy/model/enitity/enum/time_period_type.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/screens/dashboard/components/app_bar_chart.dart';
import 'package:diabuddy/screens/dashboard/components/app_line_chart.dart';
import 'package:diabuddy/screens/dashboard/diagram_screen.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class DiagramContainer extends StatelessWidget {
  const DiagramContainer({
    Key? key,
    required this.backgroundColor,
    required this.diagramTitle,
    required this.isDiagramScreen,
    required this.toolTipColor,
    required this.timePeriodType,
    required this.readings,
  }) : super(key: key);

  final Color backgroundColor;
  final Color toolTipColor;
  final String diagramTitle;
  final bool isDiagramScreen;
  final TimePeriodType timePeriodType;
  final List<GlucoseReading> readings;

  @override
  Widget build(BuildContext context) {
    final bool isBarChart = timePeriodType != TimePeriodType.today;
    final bool forMonth = timePeriodType == TimePeriodType.month;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  diagramTitle,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 24,
                      ),
                ),
                !isDiagramScreen
                    ? ColouredIconButton(
                        callback: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DiagramScreen(),
                            ),
                          );
                        },
                        backgroundColor: orangeColor,
                        icon: const Icon(
                          Icons.bar_chart_rounded,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.bar_chart_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
              ],
            ),
          ),
          isBarChart
              ? AppBarChart(
                  forMonth: forMonth,
                  data: makeDataForBarChart(),
                  barWidth: forMonth ? 15 : 22,
                )
              : AppLineChart(
                  horizontalInterval: 4,
                  toolTipColor: primaryColor,
                  maxY: 17,
                  maxX: 24,
                  data: makeDataForLineChart(),
                ),
        ],
      ),
    );
  }

  Map<double, double> makeDataForLineChart() {
    Map<double, double> data = <double, double>{};
    for (var reading in readings) {
      double key = reading.entryTime.hour.toDouble();
      key += reading.entryTime.minute.toDouble() / 10;
      data[key] = reading.glucoseValue;
    }
    return data;
  }

  Map<int, BarChartColumnValues> makeDataForBarChart() {
    bool forMonth = timePeriodType == TimePeriodType.month;
    DateTime start = forMonth
        ? DateTime.now().getStartOfMonth()
        : DateTime.now().getStartOfWeek();
    int duration = forMonth
        ? start.difference(start.getEndOfMonth()).inDays.abs()
        : DateTime.daysPerWeek;
    return calculateDataForBarChart(duration, start, forMonth);
  }

  Map<int, BarChartColumnValues> calculateDataForBarChart(
    int numberOfDaysInMonth,
    DateTime start,
    bool forMonth,
  ) {
    Map<int, BarChartColumnValues> data = <int, BarChartColumnValues>{};
    for (int i = 0; i < numberOfDaysInMonth; i++) {
      var date = start.add(Duration(days: i));
      List<GlucoseReading> list = readings
          .where((element) =>
              element.entryTime.year == date.year &&
              element.entryTime.month == date.month &&
              element.entryTime.day == date.day)
          .toList();
      if (list.isEmpty) {
        continue;
      } else {
        if (list.length != 1) {
          list.sort((a, b) => a.glucoseValue.compareTo(b.glucoseValue));
        }
        double min = list[0].glucoseValue;
        double max = list[list.length - 1].glucoseValue;
        BarChartColumnValues bar = BarChartColumnValues(max: max, min: min);
        if (forMonth) {
          data[date.day - 1] = bar;
        } else {
          data[date.weekday - 1] = bar;
        }
      }
    }
    return data;
  }
}
