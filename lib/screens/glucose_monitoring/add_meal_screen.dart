import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/screens/glucose_monitoring/add_dish_screen.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/dish_entry_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({
    Key? key,
    required this.glucoseReadingId,
  }) : super(key: key);

  final String glucoseReadingId;

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  late TextEditingController dishNameController;
  late List<Dish> dishesFiltered = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetDishes());
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
                BlocProvider.of<UserBloc>(context)
                    .add(GetGlucoseReadingById(widget.glucoseReadingId));
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is SavedGlucoseReadingDish) {
              BlocProvider.of<UserBloc>(context)
                  .add(GetGlucoseReadingDishes(widget.glucoseReadingId));
              Navigator.pop(context);
            } else {
              showSnackBar(
                context,
                AppLocalizations.of(context)!.savingGlucoseReadingDishFailed,
              );
            }
          },
          builder: (context, state) {
            if (state is! FetchedDishes) {
              return Container();
            } else {
              if (dishesFiltered.isEmpty) {
                dishesFiltered = state.dishes;
              }
              return SafeArea(
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
                        AppLocalizations.of(context)!.addYourMeal,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppLocalizations.of(context)!.searchYourDish,
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
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
                              dishesFiltered = state.dishes
                                  .where((dish) => dish.name
                                      .toLowerCase()
                                      .startsWith(text.toLowerCase()))
                                  .toList();
                            });
                          } else if (text == '') {
                            setState(() {
                              dishesFiltered = state.dishes;
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
                              addDishToGlucoseReading: addMealToGlucoseReading,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppButton(
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddDishScreen(),
                            ),
                          );
                        },
                        text: AppLocalizations.of(context)!.addNewDish,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    ]);
  }

  void addMealToGlucoseReading(Dish dish) {
    BlocProvider.of<UserBloc>(context).add(AddDishToGlucoseReading(
      dish,
      widget.glucoseReadingId,
    ));
  }
}
