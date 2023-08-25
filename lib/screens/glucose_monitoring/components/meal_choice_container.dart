import 'package:diabuddy/model/enitity/enum/meal_type.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class MealChoiceContainer extends StatelessWidget {
  const MealChoiceContainer({
    Key? key,
    required this.selected,
    required this.setMealType,
    required this.mealType,
  }) : super(key: key);

  final bool selected;
  final Function(MealType) setMealType;
  final MealType mealType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setMealType(mealType);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: selected ? primaryColor.withOpacity(0.5) : Colors.white,
          borderRadius: borderRadius,
          boxShadow: selected ? [] : [simpleBoxShadow],
        ),
        child: Center(
          child: Text(
            getMealType(mealType, context),
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color:
                      selected ? Colors.white : primaryColor.withOpacity(0.5),
                ),
          ),
        ),
      ),
    );
  }
}
