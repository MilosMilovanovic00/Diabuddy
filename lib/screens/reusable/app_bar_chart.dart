import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppBarChart extends StatelessWidget {
  const AppBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, double> nums = {
      0: 3.4,
      1: 5.6,
      2: 6.7,
      3: 5.4,
      4: 8.4,
      5: 2.6,
      6: 4.4,
      7: 9.6,
    };

    return Expanded(
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: 20,
          barGroups: nums.keys
              .map(
                (data) => BarChartGroupData(
                  x: data,
                  barRods: [
                    BarChartRodData(
                      toY: nums[data]!,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
