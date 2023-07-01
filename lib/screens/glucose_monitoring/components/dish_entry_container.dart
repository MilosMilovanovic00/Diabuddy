import 'package:diabuddy/model/enitity/Dish.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/small_app_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class DishEntryContainer extends StatefulWidget {
  const DishEntryContainer({
    Key? key,
    required this.dish,
  }) : super(key: key);

  final Dish dish;

  @override
  State<DishEntryContainer> createState() => _DishEntryContainerState();
}

class _DishEntryContainerState extends State<DishEntryContainer> {
  bool selected = false;
  late int gramsPerMeal;

  @override
  void initState() {
    super.initState();
    gramsPerMeal = widget.dish.gramsPerMeal;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10.0,
          left: 5,
          right: 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: selected ? primaryColor.withOpacity(0.7) : Colors.white,
            boxShadow: selected ? [] : [simpleBoxShadow],
            border: selected ? Border.all(color: primaryColor, width: 3) : null,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.dish.dishName,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: selected
                                ? Colors.white
                                : primaryColor.withOpacity(0.7),
                          ),
                    ),
                    Text(
                      '${widget.dish.carbohydrateValue} UH',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: selected
                                ? Colors.white
                                : primaryColor.withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ),
              selected ? buildDishExtension(context) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDishExtension(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius.copyWith(
                topLeft: const Radius.circular(0),
                topRight: const Radius.circular(0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppNumberPicker(
                        textColor: primaryColor,
                        currentValue: gramsPerMeal,
                        minValue: 0,
                        maxValue: 1000,
                        setCurrentValue: setGramsPerMeal,
                      ),
                      Text(
                        'grams',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: primaryColor.withOpacity(0.7),
                                ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmallAppButton(
                      callback: () {},
                      text: 'Edit carbs',
                      textColor: primaryColor,
                      backgroundColor: Colors.white,
                    ),
                    SmallAppButton(callback: () {}, text: 'Save'),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void setGramsPerMeal(int value) {
    setState(() {
      gramsPerMeal = value;
    });
  }
}
