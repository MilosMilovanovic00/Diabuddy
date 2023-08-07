import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/extensions/double_extensions.dart';
import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/model/enitity/enum/activity_type.dart';
import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/model/enitity/enum/meal_type.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/model/enitity/therapy.dart';
import 'package:diabuddy/screens/glucose_monitoring/activity_screen.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/meal_entry_container.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/medication_entry_container.dart';
import 'package:diabuddy/screens/glucose_monitoring/edit_glucose_level_screen.dart';
import 'package:diabuddy/screens/glucose_monitoring/edit_meal_screen.dart';
import 'package:diabuddy/screens/glucose_monitoring/edit_medication_screen.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditGlucoseEntryScreen extends StatefulWidget {
  const EditGlucoseEntryScreen({
    Key? key,
    required this.glucoseReadingId,
  }) : super(key: key);

  final String glucoseReadingId;

  @override
  State<EditGlucoseEntryScreen> createState() => _EditGlucoseEntryScreenState();
}

class _EditGlucoseEntryScreenState extends State<EditGlucoseEntryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context)
        .add(GetGlucoseReadingById(widget.glucoseReadingId));
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
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is! FetchedGlucoseReading) {
            return Container();
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
                    AppLocalizations.of(context)!.glucoseReadingDetails,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildBodyOfScreen(
                    context,
                    state.glucoseReading,
                    state.dishes,
                    state.therapy,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ]);
  }

  Expanded buildBodyOfScreen(BuildContext context,
      GlucoseReading glucoseReading, List<Dish> dishes, List<Therapy> therapy) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: goodSugarColor,
              borderRadius: borderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.glucoseLevel,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: goodSugarColor,
                      borderRadius: borderRadius,
                      boxShadow: [simpleBoxShadow],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditGlucoseLevelScreen(
                              glucoseLevel: glucoseReading.glucoseValue,
                              glucoseLevelType: glucoseReading.glucoseTiming,
                              mealType: glucoseReading.mealType,
                              glucoseReadingId: widget.glucoseReadingId,
                            ),
                          ),
                        );
                      },
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              getGlucoseTimingPathToIcon(
                                  glucoseReading.glucoseTiming),
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            Text(
                              '${glucoseReading.glucoseValue.convertByStandardUnit()}',
                              style: Theme.of(context).textTheme.displaySmall,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildMealContainer(context, dishes, glucoseReading.mealType),
          const SizedBox(
            height: 10,
          ),
          buildActivityContainer(glucoseReading, context),
          const SizedBox(
            height: 10,
          ),
          buildMedicationContainer(context, therapy),
        ],
      ),
    );
  }

  Visibility buildActivityContainer(
    GlucoseReading glucoseReading,
    BuildContext context,
  ) {
    return Visibility(
      visible: glucoseReading.activity != null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: containerColorGradient,
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${glucoseReading.activity?.name} - ${glucoseReading.activity?.duration} min\n',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextSpan(
                    text:
                        '\t${getStringForActivityIntensity(glucoseReading.activity?.intensity, context)}',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            ColouredIconButton(
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityScreen(
                      activity: glucoseReading.activity,
                      glucoseReadingId: widget.glucoseReadingId,
                    ),
                  ),
                );
              },
              backgroundColor: primaryColor,
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildMedicationContainer(
      BuildContext context, List<Therapy> therapy) {
    return Container(
      height: 250,
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.medication,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  ColouredIconButton(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditMedicationScreen(
                              glucoseReadingId: widget.glucoseReadingId),
                        ),
                      );
                    },
                    backgroundColor: primaryColor,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    itemCount: therapy.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MedicationEntryContainer(
                        therapy: therapy[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildMealContainer(
    BuildContext context,
    List<Dish> dishes,
    MealType? mealType,
  ) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: containerColorGradient,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.meal} - ${getMealType(mealType, context)}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  '${calculateTotalUH(dishes)} UH',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                ColouredIconButton(
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditMealScreen(
                          glucoseReadingId: widget.glucoseReadingId,
                        ),
                      ),
                    );
                  },
                  backgroundColor: primaryColor,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    itemCount: dishes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MealEntryContainer(
                        dish: dishes[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int calculateTotalUH(List<Dish> dishes) {
    int value = 0;
    for (var element in dishes) {
      value = value + element.carbohydrateValue;
    }
    return value;
  }
}
