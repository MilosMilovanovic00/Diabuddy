import 'package:diabuddy/screens/dashboard/app_line_chart.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class DashboardDiagramContainer extends StatelessWidget {
  const DashboardDiagramContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: orangeColor.withOpacity(0.8),
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 10.0,
              right: 10.0,
              bottom: 25.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Glucose week average',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 24,
                      ),
                ),
                const ColouredIconButton(
                  backgroundColor: orangeColor,
                  icon: Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          AppLineChart()
        ],
      ),
    );
  }
}
