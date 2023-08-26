import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/enum/meal_type.dart';
import 'package:diabuddy/screens/glucose_monitoring/add_meal_screen.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/selected_meal_container.dart';
import 'package:diabuddy/screens/glucose_monitoring/edit_medication_screen.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditMealScreen extends StatefulWidget {
  const EditMealScreen({
    Key? key,
    required this.glucoseReadingId,
    required this.newGlucoseReading,
  }) : super(key: key);

  final String glucoseReadingId;
  final bool newGlucoseReading;

  @override
  State<EditMealScreen> createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  late MealType? mealType;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(
      GetGlucoseReadingDishes(widget.glucoseReadingId),
    );
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
            child: Visibility(
              visible: !widget.newGlucoseReading,
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
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is DeletingDishFailed) {
              showSnackBar(
                context,
                AppLocalizations.of(context)!.deletingDishFailed,
              );
            }
          },
          buildWhen: (previous, current) =>
              current is FetchedGlucoseReadingDishes,
          builder: (context, state) {
            if (state is! FetchedGlucoseReadingDishes) {
              return Container();
            } else {
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
                        AppLocalizations.of(context)!.editYourMeal,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.dishes.length,
                          itemBuilder: (context, index) {
                            return SelectedMealContainer(
                              dish: state.dishes[index],
                              removeDish: removeDish,
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
                              builder: (context) => AddMealScreen(
                                glucoseReadingId: widget.glucoseReadingId,
                              ),
                            ),
                          );
                        },
                        text: AppLocalizations.of(context)!.addMeal,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: widget.newGlucoseReading,
                        child: AppButton(
                          textColor: primaryColor,
                          backgroundColor: Colors.white,
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMedicationScreen(
                                  glucoseReadingId: widget.glucoseReadingId,
                                  newGlucoseReading: widget.newGlucoseReading,
                                ),
                              ),
                            );
                          },
                          text: AppLocalizations.of(context)!.save,
                        ),
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

  void removeDish(String dishId) {
    BlocProvider.of<UserBloc>(context).add(DeleteDish(
      widget.glucoseReadingId,
      dishId,
    ));
  }
}
