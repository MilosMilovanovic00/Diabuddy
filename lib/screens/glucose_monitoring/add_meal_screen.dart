import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/dish_entry_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  late TextEditingController dishNameController;
  List<Dish> dishes = [
    Dish(name: 'Carbonara', carbohydrateValue: 40, preferredGrams: 100, id: ''),
    Dish(name: 'Bolognese', carbohydrateValue: 50, preferredGrams: 100, id: ''),
    Dish(name: 'Bread', carbohydrateValue: 15, preferredGrams: 100, id: ''),
  ];
  late List<Dish> dishesFiltered = dishes;

  @override
  void initState() {
    super.initState();
    dishNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    dishNameController.dispose();
  }

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
                  'Add your meal',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Search your dish',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldBackgroundColor,
                    errorStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                    enabledBorder: textFieldBorder,
                    errorBorder: textFieldBorder,
                    border: textFieldBorder,
                    errorMaxLines: 3,
                    contentPadding: const EdgeInsets.only(
                      left: 24,
                    ),
                  ),
                  onChanged: (text) {
                    if (text != '') {
                      setState(() {
                        dishesFiltered = dishes
                            .where((dish) => dish.name
                                .toLowerCase()
                                .startsWith(text.toLowerCase()))
                            .toList();
                      });
                    } else if (text == '') {
                      setState(() {
                        dishesFiltered = dishes;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: dishesFiltered.length,
                    itemBuilder: (context, index) {
                      return DishEntryContainer(
                        dish: dishesFiltered[index],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
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
}
