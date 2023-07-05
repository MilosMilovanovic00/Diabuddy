import 'package:diabuddy/model/enitity/enum/time_period_type.dart';
import 'package:diabuddy/screens/dashboard/components/app_bar_chart.dart';
import 'package:diabuddy/screens/dashboard/components/app_line_chart.dart';
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
  }) : super(key: key);

  final Color backgroundColor;
  final Color toolTipColor;
  final String diagramTitle;
  final bool isDiagramScreen;
  final TimePeriodType timePeriodType;

  @override
  Widget build(BuildContext context) {

    late bool isBarChart = timePeriodType != TimePeriodType.today;
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
                    ? const ColouredIconButton(
                        backgroundColor: orangeColor,
                        icon: Icon(
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
              ? AppBarChart()
              : const AppLineChart(
                  horizontalInterval: 4,
                  toolTipColor: primaryColor,
                  maxY: 17,
                  maxX: 18,
                ),
        ],
      ),
    );
  }
}
