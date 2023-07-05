import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarChart extends StatefulWidget {
  AppBarChart({
    super.key,
  });

  final Color barBackgroundColor = primaryColor.withOpacity(0.3);
  final Color barColor = primaryColor.withOpacity(0.5);
  final Color touchedBarColor = primaryColor;

  @override
  State<StatefulWidget> createState() => AppBarChartState();
}

class AppBarChartState extends State<AppBarChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          bottom: 25,
        ),
        child: BarChart(BarChartData(
          maxY: 17,
          minY: 0,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: primaryColor.withOpacity(0.7),
              tooltipHorizontalAlignment: FLHorizontalAlignment.center,
              tooltipMargin: 10,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String weekDay;
                switch (group.x) {
                  case 0:
                    weekDay = AppLocalizations.of(context)!.monday;
                    break;
                  case 1:
                    weekDay = AppLocalizations.of(context)!.tuesday;
                    break;
                  case 2:
                    weekDay = AppLocalizations.of(context)!.wednesday;
                    break;
                  case 3:
                    weekDay = AppLocalizations.of(context)!.thursday;
                    break;
                  case 4:
                    weekDay = AppLocalizations.of(context)!.friday;
                    break;
                  case 5:
                    weekDay = AppLocalizations.of(context)!.saturday;
                    break;
                  case 6:
                    weekDay = AppLocalizations.of(context)!.sunday;
                    break;
                  default:
                    throw Error();
                }
                return BarTooltipItem(
                  '$weekDay\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${rod.fromY} - ${rod.toY}',
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                );
              },
            ),
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              });
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitles,
                reservedSize: 38,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 2,
                showTitles: true,
                reservedSize: 45,
                getTitlesWidget: getLeftTitles,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.4),
                width: 2,
                style: BorderStyle.solid,
              ),
              left: const BorderSide(color: Colors.transparent),
              right: const BorderSide(color: Colors.transparent),
              top: const BorderSide(color: Colors.transparent),
            ),
          ),
          barGroups: showingGroups(),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.white.withOpacity(0.4), strokeWidth: 2,
              dashArray: [5, 5], // Adjust the dash array as desired
            ),
            horizontalInterval: 4, //koliko ce biti interval izmedju linija
            // getDrawingHorizontalLine: ,
          ),
        )
            // mainBarData(),
            ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double fromY,
    double toY, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          fromY: fromY,
          borderRadius: borderRadius,
          toY: toY,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : BorderSide(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(11, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, 12, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, 8, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, 10, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 2.5, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 4.4, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 4, 6.5, isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(6, 4, 6.5, isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(6, 4, 6.5, isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(6, 4, 6.5, isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(0, 5, 12, isTouched: i == touchedIndex);

          default:
            return throw Error();
        }
      });

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(AppLocalizations.of(context)!.monday[0], style: style);
        break;
      case 1:
        text = Text(AppLocalizations.of(context)!.tuesday[0], style: style);
        break;
      case 2:
        text = Text(AppLocalizations.of(context)!.wednesday[0], style: style);
        break;
      case 3:
        text = Text(AppLocalizations.of(context)!.thursday[0], style: style);
        break;
      case 4:
        text = Text(AppLocalizations.of(context)!.friday[0], style: style);
        break;
      case 5:
        text = Text(AppLocalizations.of(context)!.saturday[0], style: style);
        break;
      case 6:
        text = Text(AppLocalizations.of(context)!.sunday[0], style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0', style: style);
        break;
      case 4:
        text = const Text('4', style: style);
        break;
      case 8:
        text = const Text('8', style: style);
        break;
      case 12:
        text = const Text('12', style: style);
        break;
      case 16:
        text = const Text('16', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
