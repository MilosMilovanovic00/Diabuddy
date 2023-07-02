import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/meal_choice_picker.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/selected_meal_container.dart';
import 'package:diabuddy/screens/reusable/app_add_button.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditMealScreen extends StatefulWidget {
  const EditMealScreen({Key? key}) : super(key: key);

  @override
  State<EditMealScreen> createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  List<Dish> dishes = [
    Dish(dishName: 'Carbonara', carbohydrateValue: 40, gramsPerMeal: 100),
    Dish(dishName: 'Bolognese', carbohydrateValue: 50, gramsPerMeal: 100),
    Dish(dishName: 'Bread', carbohydrateValue: 15, gramsPerMeal: 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 75,
          toolbarHeight: 70,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              top: 20,
            ),
            child: AppIconButton(
              callback: () {
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Edit your meal',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                const MealChoicePicker(),
                const SizedBox(
                  height: 20,
                ),
                AppAddButton(
                  text: "Add a meal",
                  callback: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: dishes.length,
                    itemBuilder: (context, index) {
                      return SelectedMealContainer(
                        dish: dishes[index],
                        removeDish: removeDish,
                      );
                    },
                  ),
                ),
                AppButton(
                  callback: () {},
                  text: AppLocalizations.of(context)!.save,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  void removeDish(Dish dish) {
    setState(() {
      dishes.remove(dish);
    });
  }
}
