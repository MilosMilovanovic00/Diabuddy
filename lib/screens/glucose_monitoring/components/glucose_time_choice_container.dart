import 'package:diabuddy/model/enitity/glucose_type.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class GlucoseTimeChoiceContainer extends StatelessWidget {
  const GlucoseTimeChoiceContainer({
    Key? key,
    required this.selected,
    required this.mealSelector,
    required this.type,
  }) : super(key: key);

  final bool selected;
  final Function(GlucoseTimeType) mealSelector;
  final GlucoseTimeType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mealSelector(type);
      },
      child: Container(
        decoration: BoxDecoration(
            color: selected ? primaryColor.withOpacity(0.5) : Colors.white,
            borderRadius: borderRadius,
            boxShadow: selected ? [] : [simpleBoxShadow]),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getGlucoseLevelTypeTitle(type, context),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: !selected
                          ? primaryColor.withOpacity(0.7)
                          : Colors.white,
                    ),
              ),
              // Ovo treba da se zameni sa ikonicama svg
              Icon(
                Icons.home,
                color: !selected ? primaryColor : Colors.white,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
