import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/glucose_time_choice_container.dart';
import 'package:flutter/material.dart';

class GlucoseTimeChoicePicker extends StatefulWidget {
  const GlucoseTimeChoicePicker({
    Key? key,
    this.type,
  }) : super(key: key);

  final GlucoseTiming? type;

  @override
  State<GlucoseTimeChoicePicker> createState() =>
      _GlucoseTimeChoicePickerState();
}

class _GlucoseTimeChoicePickerState extends State<GlucoseTimeChoicePicker> {
  late bool beforeMealSelected = false;
  late bool afterMealSelected = false;
  late bool fastingSelected = false;
  late GlucoseTiming? glucoseTimeType;

  @override
  void initState() {
    super.initState();
    glucoseTimeType = widget.type;
    if (glucoseTimeType != null) {
      switch (glucoseTimeType!) {
        case GlucoseTiming.beforeMeal:
          beforeMealSelected = true;
          break;
        case GlucoseTiming.afterMeal:
          afterMealSelected = true;
          break;
        case GlucoseTiming.fasting:
          fastingSelected = true;
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlucoseTimeChoiceContainer(
          selected: beforeMealSelected,
          mealSelector: setGlucoseTimeType,
          type: GlucoseTiming.beforeMeal,
        ),
        const SizedBox(
          height: 15,
        ),
        GlucoseTimeChoiceContainer(
          selected: afterMealSelected,
          mealSelector: setGlucoseTimeType,
          type: GlucoseTiming.afterMeal,
        ),
        const SizedBox(
          height: 15,
        ),
        GlucoseTimeChoiceContainer(
          selected: fastingSelected,
          mealSelector: setGlucoseTimeType,
          type: GlucoseTiming.fasting,
        ),
      ],
    );
  }

  void setGlucoseTimeType(GlucoseTiming type) {
    setState(() {
      glucoseTimeType = type;
    });
    switch (glucoseTimeType!) {
      case GlucoseTiming.beforeMeal:
        setState(() {
          beforeMealSelected = true;
          afterMealSelected = false;
          fastingSelected = false;
        });
        break;
      case GlucoseTiming.afterMeal:
        setState(() {
          beforeMealSelected = false;
          afterMealSelected = true;
          fastingSelected = false;
        });
        break;
      case GlucoseTiming.fasting:
        setState(() {
          beforeMealSelected = false;
          afterMealSelected = false;
          fastingSelected = true;
        });
        break;
    }
  }
}
