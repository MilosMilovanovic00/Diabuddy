import 'package:diabuddy/model/enitity/Dish.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class SelectedMealContainer extends StatelessWidget {
  const SelectedMealContainer({
    Key? key,
    required this.dish,
    required this.removeDish,
  }) : super(key: key);

  final Dish dish;
  final Function(Dish) removeDish;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.7),
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: '${dish.dishName}\n\n',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                TextSpan(
                  text: '${dish.gramsPerMeal} g',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 14,
                      ),
                ),
              ]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    removeDish(dish);
                  },
                  child: const ColouredIconButton(
                    backgroundColor: primaryColor,
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${dish.carbohydrateValue} UH',
                  style: Theme.of(context).textTheme.displaySmall,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
