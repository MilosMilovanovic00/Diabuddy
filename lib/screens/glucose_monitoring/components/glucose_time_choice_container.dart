import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlucoseTimeChoiceContainer extends StatelessWidget {
  const GlucoseTimeChoiceContainer({
    Key? key,
    required this.selected,
    required this.mealSelector,
    required this.glucoseTiming,
  }) : super(key: key);

  final bool selected;
  final Function(GlucoseTiming) mealSelector;
  final GlucoseTiming glucoseTiming;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mealSelector(glucoseTiming);
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
                getGlucoseTimingTitle(glucoseTiming, context),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: !selected
                          ? primaryColor.withOpacity(0.7)
                          : Colors.white,
                    ),
              ),
              SvgPicture.asset(
                getGlucoseTimingPathToIcon(glucoseTiming),
                colorFilter: ColorFilter.mode(
                    !selected ? primaryColor : Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
