import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/app_text_field_input.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDishScreen extends StatefulWidget {
  const AddDishScreen({Key? key, this.dish}) : super(key: key);

  final Dish? dish;

  @override
  State<AddDishScreen> createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController dishNameController;

  late bool isEditScreen;
  late int carbohydrateValue;

  @override
  void initState() {
    super.initState();
    dishNameController = TextEditingController();
    isEditScreen = widget.dish != null;
    dishNameController.text = widget.dish?.name ?? "";
    carbohydrateValue = widget.dish?.carbohydrateValue ?? 50;
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
                BlocProvider.of<UserBloc>(context).add(GetDishes());
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        body: BlocListener<UserBloc, UserState>(
          listener: (BuildContext context, state) {
            if (state is NewDishSavingFailed) {
              showSnackBar(
                context,
                AppLocalizations.of(context)!.savingNewDishFailed,
              );
            } else if (state is DishUpdatedFailed) {
              showSnackBar(
                  context, AppLocalizations.of(context)!.updatingNewDishFailed);
            } else if (state is NewDishSaved || state is DishUpdated) {
              BlocProvider.of<UserBloc>(context).add(GetDishes());
              Navigator.pop(context);
            }
          },
          child: SafeArea(
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
                    isEditScreen
                        ? AppLocalizations.of(context)!.editYourDish
                        : AppLocalizations.of(context)!.addYourDish,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: AppTextFieldInput(
                      hintText: AppLocalizations.of(context)!.dishName,
                      controller: dishNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .youMustEnterDishName;
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildCarbohydrateValueOfDishPicker(context),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppButton(
                    callback: () {
                      if (isEditScreen) {
                        editDish();
                      }
                      if (_formKey.currentState!.validate()) {
                        saveNewDish();
                      }
                    },
                    text: AppLocalizations.of(context)!.save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Container buildCarbohydrateValueOfDishPicker(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        shape: BoxShape.rectangle,
        gradient: containerColorGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.mealCarbohydrateValuePer100g,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 20.0,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppNumberPicker(
                minValue: 0,
                maxValue: 100,
                setCurrentValue: setCarbohydrateValue),
          ],
        ),
      ),
    );
  }

  void setCarbohydrateValue(int value) {
    setState(() {
      carbohydrateValue = value;
    });
  }

  void saveNewDish() {
    Dish dish = Dish(
      name: dishNameController.text.trim(),
      carbohydrateValue: carbohydrateValue,
      grams: 100,
    );
    BlocProvider.of<UserBloc>(context).add(SaveNewDish(dish));
  }

  void editDish() {
    Dish dish = Dish(
      id: widget.dish!.id,
      name: dishNameController.text.trim(),
      carbohydrateValue: carbohydrateValue,
      grams: widget.dish!.grams,
    );
    BlocProvider.of<UserBloc>(context).add(EditDish(dish));
  }
}
