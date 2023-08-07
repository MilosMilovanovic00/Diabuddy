import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/model/enitity/enum/meal_type.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/glucose_time_choice_picker.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/meal_choice_picker.dart';
import 'package:diabuddy/screens/onboarding/components/simple_app_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGlucoseLevelScreen extends StatefulWidget {
  const EditGlucoseLevelScreen({
    Key? key,
    this.glucoseLevel,
    this.glucoseLevelType,
    required this.glucoseReadingId,
    this.mealType,
  }) : super(key: key);

  final String glucoseReadingId;
  final double? glucoseLevel;
  final GlucoseTiming? glucoseLevelType;
  final MealType? mealType;

  @override
  State<EditGlucoseLevelScreen> createState() => _EditGlucoseLevelScreenState();
}

class _EditGlucoseLevelScreenState extends State<EditGlucoseLevelScreen> {
  late int glucoseLevelFirstDigit;
  late int glucoseLevelSecondDigit;
  late GlucoseTiming glucoseTiming;
  late MealType? mealType;

  @override
  void initState() {
    super.initState();
    String value = widget.glucoseLevel.toString();
    glucoseLevelFirstDigit =
        widget.glucoseLevel != null ? int.parse(value.split('.')[0]) : 5;
    glucoseLevelSecondDigit =
        widget.glucoseLevel != null ? int.parse(value.split('.')[1]) : 0;
    glucoseTiming = widget.glucoseLevelType ?? GlucoseTiming.fasting;
    mealType = widget.mealType;
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
        body: BlocListener<UserBloc, UserState>(
          listener: (BuildContext context, state) {
            if (state is SuccessfullyUpdatedGlucoseReading) {
              BlocProvider.of<UserBloc>(context)
                  .add(GetGlucoseReadingById(widget.glucoseReadingId));
              Navigator.pop(context);
            } else {
              //TODO pop up nije dobro
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
                    AppLocalizations.of(context)!.editGlucoseLevel,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildBody(context),
                  const Spacer(),
                  AppButton(
                    callback: () {
                      updateGlucoseReading();
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

  SizedBox buildBody(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SimpleAppContainer(
                text: AppLocalizations.of(context)!.glucoseLevel,
                widget: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      AppNumberPicker(
                        axis: Axis.vertical,
                        widgetHeight: 40,
                        widgetWidth: 40,
                        selectedTextSize: 20,
                        unselectedTextSize: 14,
                        minValue: 1,
                        maxValue: 30,
                        currentValue: glucoseLevelFirstDigit,
                        setCurrentValue: setFirstDigit,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '.',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      AppNumberPicker(
                        axis: Axis.vertical,
                        widgetHeight: 40,
                        widgetWidth: 40,
                        selectedTextSize: 20,
                        unselectedTextSize: 14,
                        minValue: 0,
                        maxValue: 9,
                        currentValue: glucoseLevelSecondDigit,
                        setCurrentValue: setSecondDigit,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GlucoseTimeChoicePicker(
                type: glucoseTiming,
                setGlucoseTiming: setGlucoseTiming,
              ),
              const SizedBox(
                height: 30,
              ),
              MealChoicePicker(
                mealType: mealType,
                setMealType: setMealType,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setFirstDigit(int value) {
    setState(() {
      glucoseLevelFirstDigit = value;
    });
  }

  void setSecondDigit(int value) {
    setState(() {
      glucoseLevelSecondDigit = value;
    });
  }

  void setGlucoseTiming(GlucoseTiming value) {
    setState(() {
      glucoseTiming = value;
    });
  }

  void setMealType(MealType? value) {
    setState(() {
      mealType = value;
    });
  }

  void updateGlucoseReading() {
    UpdateGlucoseReading event = UpdateGlucoseReading(
      double.parse('$glucoseLevelFirstDigit.$glucoseLevelSecondDigit'),
      glucoseTiming,
      widget.glucoseReadingId,
      mealType,
    );
    BlocProvider.of<UserBloc>(context).add(event);
  }
}
