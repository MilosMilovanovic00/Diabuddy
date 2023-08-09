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
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/meal_entry_container.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/medication_entry_container.dart';
import 'package:diabuddy/screens/glucose_monitoring/edit_glucose_entry_screen.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlucoseEntryScreen extends StatefulWidget {
  const GlucoseEntryScreen({
    Key? key,
    required this.glucoseReadingId,
  }) : super(key: key);

  final String glucoseReadingId;

  @override
  State<GlucoseEntryScreen> createState() => _GlucoseEntryScreenState();
}

class _GlucoseEntryScreenState extends State<GlucoseEntryScreen> {
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
                BlocProvider.of<UserBloc>(context).add(GetAllGlucoseReadings());
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
                  AppButton(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditGlucoseEntryScreen(
                            glucoseReadingId: widget.glucoseReadingId,
                          ),
                        ),
                      );
                    },
                    text: AppLocalizations.of(context)!.edit,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ]);
  }

  Expanded buildBodyOfScreen(
    BuildContext context,
    GlucoseReading glucoseReading,
    List<Dish> dishes,
    List<Therapy> therapy,
  ) {
    final bool isStandardUnit =
        UserSimplePreferences.isStandardMeasurementUnit();
    final Color backColor =
        glucoseReading.glucoseValue.getColorByGlucoseLevel();
    return Expanded(
      child: ListView(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: backColor,
              borderRadius: borderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.glucoseLevel,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SvgPicture.asset(
                    getGlucoseTimingPathToIcon(glucoseReading.glucoseTiming),
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  Text(
                    '${glucoseReading.glucoseValue.convertByStandardUnit()} '
                    '${isStandardUnit ? 'mmol/L' : 'mg/dl'}',
                    style: Theme.of(context).textTheme.displaySmall,
                  )
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
          Visibility(
            visible: glucoseReading.activity != null,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: containerColorGradient,
                borderRadius: borderRadius,
              ),
              child: RichText(
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
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildMedicationContainer(context, therapy),
        ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.medication,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 190,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.meal} - ${getMealType(mealType, context)}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  '${calculateTotalUH(dishes)} UH',
                  style: Theme.of(context).textTheme.displaySmall,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 190,
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
