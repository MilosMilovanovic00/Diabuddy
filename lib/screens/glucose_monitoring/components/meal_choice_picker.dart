import 'package:diabuddy/model/enitity/meal_type.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/meal_choice_container.dart';
import 'package:flutter/material.dart';

class MealChoicePicker extends StatefulWidget {
  const MealChoicePicker({
    Key? key,
    this.mealType,
  }) : super(key: key);

  final MealType? mealType;

  @override
  State<MealChoicePicker> createState() => _MealChoicePickerState();
}

class _MealChoicePickerState extends State<MealChoicePicker> {
  late bool breakfastSelected = false;
  late bool lunchSelected = false;
  late bool snackSelected = false;
  late bool dinnerSelected = false;

  late MealType? type;

  @override
  void initState() {
    super.initState();
    type = widget.mealType;
    if (type != null) {
      switch (type!) {
        case MealType.breakfast:
          breakfastSelected = true;
          break;
        case MealType.lunch:
          lunchSelected = false;
          break;
        case MealType.dinner:
          dinnerSelected = true;
          break;
        case MealType.snack:
          snackSelected = true;
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MealChoiceContainer(
                selected: breakfastSelected,
                setMealType: setMealType,
                mealType: MealType.breakfast,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: MealChoiceContainer(
                selected: lunchSelected,
                setMealType: setMealType,
                mealType: MealType.lunch,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: MealChoiceContainer(
                selected: dinnerSelected,
                setMealType: setMealType,
                mealType: MealType.dinner,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: MealChoiceContainer(
                selected: snackSelected,
                setMealType: setMealType,
                mealType: MealType.snack,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void setMealType(MealType mealType) {
    setState(() {
      type = mealType;
    });
    switch (type!) {
      case MealType.breakfast:
        breakfastSelected = true;
        lunchSelected = snackSelected = dinnerSelected = false;
        break;
      case MealType.lunch:
        lunchSelected = true;
        breakfastSelected = snackSelected = dinnerSelected = false;
        break;
      case MealType.dinner:
        dinnerSelected = true;
        lunchSelected = snackSelected = breakfastSelected = false;
        break;
      case MealType.snack:
        snackSelected = true;
        lunchSelected = breakfastSelected = dinnerSelected = false;
        break;
    }
  }
}
