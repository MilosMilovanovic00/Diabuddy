import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/screens/glucose_monitoring/add_dish_screen.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/small_app_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DishEntryContainer extends StatefulWidget {
  const DishEntryContainer({
    Key? key,
    required this.dish,
    required this.addDishToGlucoseReading,
  }) : super(key: key);

  final Dish dish;

  final Function(Dish) addDishToGlucoseReading;

  @override
  State<DishEntryContainer> createState() => _DishEntryContainerState();
}

class _DishEntryContainerState extends State<DishEntryContainer> {
  bool selected = false;
  late int gramsPerMeal;

  @override
  void initState() {
    super.initState();
    gramsPerMeal = widget.dish.grams;
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
                      widget.dish.name,
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
                        AppLocalizations.of(context)!.grams,
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
                      callback: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddDishScreen(dish: widget.dish),
                          ),
                        );
                      },
                      text: AppLocalizations.of(context)!.edit,
                      textColor: primaryColor,
                      backgroundColor: Colors.white,
                    ),
                    SmallAppButton(
                      callback: () {
                        addDish();
                      },
                      text: AppLocalizations.of(context)!.save,
                    ),
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

  void addDish() {
    Dish dish = Dish(
      name: widget.dish.name,
      carbohydrateValue: widget.dish.carbohydrateValue * gramsPerMeal ~/ 100,
      grams: gramsPerMeal,
    );
    widget.addDishToGlucoseReading(dish);
  }
}
