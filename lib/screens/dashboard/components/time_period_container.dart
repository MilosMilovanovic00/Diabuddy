import 'package:diabuddy/model/enitity/enum/time_period_type.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class TimePeriodContainer extends StatelessWidget {
  const TimePeriodContainer({
    Key? key,
    required this.selected,
    required this.setTimePeriod,
    required this.defaultTimePeriod,
  }) : super(key: key);

  final bool selected;
  final Function(TimePeriodType) setTimePeriod;
  final TimePeriodType defaultTimePeriod;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setTimePeriod(defaultTimePeriod);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? primaryColor.withOpacity(0.7) : Colors.white,
          borderRadius: borderRadius,
          boxShadow: selected ? [] : [simpleBoxShadow],
        ),
        child: Center(
          child: Text(
            getTimePeriodType(
              context,
              defaultTimePeriod,
            ),
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color:
                      selected ? Colors.white : primaryColor.withOpacity(0.7),
                ),
          ),
        ),
      ),
    );
  }
}
