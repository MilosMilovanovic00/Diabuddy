import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/glucose_time_choice_container.dart';
import 'package:flutter/material.dart';

class GlucoseTimeChoicePicker extends StatefulWidget {
  const GlucoseTimeChoicePicker({
    Key? key,
    this.type,
  }) : super(key: key);

  final GlucoseTimeType? type;

  @override
  State<GlucoseTimeChoicePicker> createState() =>
      _GlucoseTimeChoicePickerState();
}

class _GlucoseTimeChoicePickerState extends State<GlucoseTimeChoicePicker> {
  late bool beforeMealSelected = false;
  late bool afterMealSelected = false;
  late bool fastingSelected = false;
  late GlucoseTimeType? glucoseTimeType;

  @override
  void initState() {
    super.initState();
    glucoseTimeType = widget.type;
    if (glucoseTimeType != null) {
      switch (glucoseTimeType!) {
        case GlucoseTimeType.beforeMeal:
          beforeMealSelected = true;
          break;
        case GlucoseTimeType.afterMeal:
          afterMealSelected = true;
          break;
        case GlucoseTimeType.fasting:
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
          type: GlucoseTimeType.beforeMeal,
        ),
        const SizedBox(
          height: 15,
        ),
        GlucoseTimeChoiceContainer(
          selected: afterMealSelected,
          mealSelector: setGlucoseTimeType,
          type: GlucoseTimeType.afterMeal,
        ),
        const SizedBox(
          height: 15,
        ),
        GlucoseTimeChoiceContainer(
          selected: fastingSelected,
          mealSelector: setGlucoseTimeType,
          type: GlucoseTimeType.fasting,
        ),
      ],
    );
  }

  void setGlucoseTimeType(GlucoseTimeType type) {
    setState(() {
      glucoseTimeType = type;
    });
    switch (glucoseTimeType!) {
      case GlucoseTimeType.beforeMeal:
        setState(() {
          beforeMealSelected = true;
          afterMealSelected = false;
          fastingSelected = false;
        });
        break;
      case GlucoseTimeType.afterMeal:
        setState(() {
          beforeMealSelected = false;
          afterMealSelected = true;
          fastingSelected = false;
        });
        break;
      case GlucoseTimeType.fasting:
        setState(() {
          beforeMealSelected = false;
          afterMealSelected = false;
          fastingSelected = true;
        });
        break;
    }
  }
}
