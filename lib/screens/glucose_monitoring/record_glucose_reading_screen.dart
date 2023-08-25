import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/extensions/double_extensions.dart';
import 'package:diabuddy/model/activity.dart';
import 'package:diabuddy/model/enitity/enum/activity_type.dart';
import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/model/enitity/enum/meal_type.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/screens/glucose_monitoring/edit_meal_screen.dart';
import 'package:diabuddy/screens/onboarding/components/simple_app_container.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_dropdown_container.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecordGlucoseReadingScreen extends StatefulWidget {
  const RecordGlucoseReadingScreen({super.key});

  @override
  State<RecordGlucoseReadingScreen> createState() =>
      _RecordGlucoseReadingScreenState();
}

class _RecordGlucoseReadingScreenState
    extends State<RecordGlucoseReadingScreen> {
  late TextEditingController glucoseValueController;
  late TextEditingController activityNameController;
  late double glucoseValue;
  late GlucoseTiming glucoseTiming;
  late MealType? chosenMealType;
  late Activity? activity;
  late int duration;
  late ActivityIntensity intensity;

  @override
  void initState() {
    super.initState();
    duration = 60;
    intensity = ActivityIntensity.values.first;
    activity = null;
    chosenMealType = MealType.values.first;
    glucoseValueController = TextEditingController();
    activityNameController = TextEditingController();
    glucoseValue = 0;
    glucoseValueController.text = glucoseValue.toString();
    glucoseTiming = GlucoseTiming.fasting;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Scaffold(
        backgroundColor: primaryColor.withOpacity(0.10),
        bottomNavigationBar: const AppBottomNavigationBar(
          selectedIndex: 2,
        ),
        body: BlocListener<UserBloc, UserState>(
          listener: (BuildContext context, state) {
            if (state is SavedGlucoseReading) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditMealScreen(
                    glucoseReadingId: state.glucoseReadingId,
                    newGlucoseReading: true,
                  ),
                ),
              );
            } else if (state is SavingGlucoseReadingFailed) {
              showSnackBar(
                context,
                AppLocalizations.of(context)!.savingGlucoseReadingTherapyFailed,
              );
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.recordYourGlucoseReading,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: containerColorGradient,
                      borderRadius: borderRadius,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.glucoseLevel,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: borderRadius,
                            boxShadow: [simpleBoxShadow],
                          ),
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: borderRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  getGlucoseTimingPathToIcon(glucoseTiming),
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
                                ),
                                Text(
                                  '${glucoseValue.convertByStandardUnit()}',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                )
                              ],
                            ),
                          ),
                        ),
                        ColouredIconButton(
                          callback: () {
                            showGlucoseValueAndTimingDialog(
                              context,
                              glucoseValueController,
                              glucoseTiming,
                              setGlucoseTiming,
                              setGlucoseValue,
                            );
                          },
                          backgroundColor: Colors.white,
                          icon: const Icon(
                            Icons.edit,
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: glucoseTiming != GlucoseTiming.fasting,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SimpleAppContainer(
                        text: AppLocalizations.of(context)!.chooseMealType,
                        widget: AppDropdownContainer(
                          setChoice: setMealChoice,
                          choices: MealType.values,
                          choice: chosenMealType,
                        ),
                      ),
                    ),
                  ),
                  buildActivityContainer(context),
                  const Spacer(),
                  AppButton(
                    callback: () {
                      saveGlucoseEntry();
                    },
                    text: AppLocalizations.of(context)!.save,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Container buildActivityContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: containerColorGradient,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.activity,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                ColouredIconButton(
                  callback: () {
                    showActivityDialog(
                      context,
                      activityNameController,
                      duration,
                      setActivityType,
                      setActivityDuration,
                      intensity,
                      setActivity,
                    );
                  },
                  backgroundColor: Colors.white,
                  icon: const Icon(
                    Icons.edit,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            activity != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${activity!.name} - $duration min',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontSize: 20,
                                  ),
                            ),
                            Text(
                              getStringForActivityIntensity(
                                  activity!.intensity, context),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontSize: 20,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  String calculateGlucoseValue() {
    return double.parse(glucoseValueController.text)
        .convertByStandardUnit()
        .toString();
  }

  void setGlucoseTiming(
    GlucoseTiming timing,
  ) {
    setState(() {
      glucoseTiming = timing;
    });
  }

  void setGlucoseValue(
    double value,
  ) {
    setState(() {
      glucoseValue = value;
    });
  }

  void setMealChoice(dynamic mealType) {
    setState(() {
      chosenMealType = mealType;
    });
  }

  void setActivityType(dynamic activityType) {
    setState(() {
      intensity = activityType;
    });
  }

  void setActivityDuration(int value) {
    setState(() {
      duration = value;
    });
  }

  void setActivity(Activity activityValue) {
    setState(() {
      activity = activityValue;
    });
  }

  void saveGlucoseEntry() {
    if (glucoseValue == 0) {
      showSnackBar(
        context,
        AppLocalizations.of(context)!.enterGlucoseValue,
      );
      return;
    }
    GlucoseReading glucoseReading = GlucoseReading(
      entryTime: DateTime.now(),
      glucoseValue: glucoseValue,
      glucoseTiming: glucoseTiming,
      medicationTaken: false,
      mealTaken: glucoseTiming != GlucoseTiming.fasting,
      activity: activity,
      mealType: glucoseTiming != GlucoseTiming.fasting ? chosenMealType : null,
    );
    BlocProvider.of<UserBloc>(context)
        .add(AddNewGlucoseReading(glucoseReading));
  }
}
