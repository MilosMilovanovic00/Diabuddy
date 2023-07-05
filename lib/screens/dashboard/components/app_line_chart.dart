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
  }) : super(key: key);

  final double horizontalInterval;
  final Color toolTipColor;
  final double maxY;
  final double maxX;

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
              horizontalInterval:
                  horizontalInterval, //koliko ce biti interval izmedju linija
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
        reservedSize: 45,
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
      case 0:
        text = const Text('7:00', style: style);
        break;
      case 5:
        text = const Text('12:00', style: style);
        break;
      case 11:
        text = const Text('18:00', style: style);
        break;
      case 16:
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
        spots: const [
          FlSpot(1, 3.8),
          FlSpot(3, 10.9),
          FlSpot(3.1, 8.9),
          FlSpot(4, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
      );
}
