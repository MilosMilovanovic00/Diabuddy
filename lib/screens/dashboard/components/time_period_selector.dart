import 'package:diabuddy/model/enitity/enum/time_period_type.dart';
import 'package:diabuddy/screens/dashboard/components/time_period_container.dart';
import 'package:flutter/material.dart';

class TimePeriodSelector extends StatefulWidget {
  const TimePeriodSelector({
    Key? key,
    required this.timePeriodType,
    required this.callback,
  }) : super(key: key);

  final TimePeriodType timePeriodType;
  final Function(TimePeriodType) callback;

  @override
  State<TimePeriodSelector> createState() => _TimePeriodSelectorState();
}

class _TimePeriodSelectorState extends State<TimePeriodSelector> {
  late TimePeriodType type;
  late bool monthSelected = false;
  late bool weekSelected = false;
  late bool todaySelected = false;

  @override
  void initState() {
    super.initState();
    type = widget.timePeriodType;
    switch (type) {
      case TimePeriodType.today:
        todaySelected = true;
        break;
      case TimePeriodType.week:
        weekSelected = true;
        break;
      case TimePeriodType.month:
        monthSelected = true;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TimePeriodContainer(
          selected: todaySelected,
          setTimePeriod: setTimePeriod,
          defaultTimePeriod: TimePeriodType.today,
        ),
        TimePeriodContainer(
          selected: weekSelected,
          setTimePeriod: setTimePeriod,
          defaultTimePeriod: TimePeriodType.week,
        ),
        TimePeriodContainer(
          selected: monthSelected,
          setTimePeriod: setTimePeriod,
          defaultTimePeriod: TimePeriodType.month,
        ),
      ],
    );
  }

  void setTimePeriod(TimePeriodType timePeriodType) {
    setState(() {
      type = timePeriodType;
    });
    switch (type) {
      case TimePeriodType.today:
        setState(() {
          todaySelected = true;
          weekSelected = false;
          monthSelected = false;
        });
        break;
      case TimePeriodType.week:
        setState(() {
          todaySelected = false;
          weekSelected = true;
          monthSelected = false;
        });
        break;
      case TimePeriodType.month:
        setState(() {
          todaySelected = false;
          weekSelected = false;
          monthSelected = true;
        });
        break;
    }
    widget.callback(timePeriodType);
  }
}
