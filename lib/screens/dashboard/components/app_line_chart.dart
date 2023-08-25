import 'package:diabuddy/extensions/int_extenstions.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppLineChart extends StatelessWidget {
  const AppLineChart({
    Key? key,
    required this.horizontalInterval,
    required this.toolTipColor,
    required this.maxY,
    required this.maxX,
    required this.data,
  }) : super(key: key);

  final double horizontalInterval;
  final Color toolTipColor;
  final double maxY;
  final double maxX;
  final Map<double, double> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          bottom: 25,
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              handleBuiltInTouches: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: toolTipColor,
                tooltipRoundedRadius: 10,
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.white.withOpacity(0.4), strokeWidth: 2,
                dashArray: [5, 5], // Adjust the dash array as desired
              ),
              horizontalInterval: horizontalInterval,
              // getDrawingHorizontalLine: ,
            ),
            titlesData: chartTitles,
            borderData: borderData,
            lineBarsData: [lineChart],
            minX: 0,
            maxX: maxX,
            maxY: maxY,
            minY: 0,
          ),
        ),
      ),
    );
  }

  SideTitles get leftTitles => SideTitles(
        getTitlesWidget: getLeftTitles,
        showTitles: true,
        interval: 2,
        reservedSize: 48,
      );

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
        text = Text('${4.convertByStandardUnit()}', style: style);
        break;
      case 8:
        text = Text('${8.convertByStandardUnit()}', style: style);
        break;
      case 12:
        text = Text('${12.convertByStandardUnit()}', style: style);
        break;
      case 16:
        text = Text('${16.convertByStandardUnit()}', style: style);
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

  FlTitlesData get chartTitles => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles,
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 40,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(
    double value,
    TitleMeta meta,
  ) {
    Widget text;
    const style = TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        fontFamily: 'SourceSansPro',
        color: Colors.white);
    switch (value.toInt()) {
      case 2:
        text = const Text('3:00', style: style);
        break;
      case 7:
        text = const Text('7:00', style: style);
        break;
      case 12:
        text = const Text('12:00', style: style);
        break;
      case 17:
        text = const Text('17:00', style: style);
        break;
      case 22:
        text = const Text('22:00', style: style);
        break;
      default:
        text = const Text('');
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
              color: Colors.white, width: 2, style: BorderStyle.solid),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChart => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.white,
        shadow: const BoxShadow(color: orangeColor),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(show: false),
        spots: data.entries
            .map((entry) => FlSpot(entry.key, entry.value))
            .toList(),
      );
}
