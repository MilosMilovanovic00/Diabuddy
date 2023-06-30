import 'package:diabuddy/screens/glucose_monitoring/components/meal_entry_container.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/medication_entry_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlucoseEntryScreen extends StatelessWidget {
  const GlucoseEntryScreen({Key? key}) : super(key: key);

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
                  'Entry Details',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                buildBodyOfScreen(context),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                  callback: () {},
                  text: AppLocalizations.of(context)!.edit,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Expanded buildBodyOfScreen(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: goodSugarColor,
              borderRadius: borderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Glucose level',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    '5.6 mmol/L',
                    style: Theme.of(context).textTheme.displaySmall,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildMealContainer(context),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: containerColorGradient,
              borderRadius: borderRadius,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Climbing ',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextSpan(
                    text: '- 240 min \n',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextSpan(
                    text: '\tModerate',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildMedicationContainer(context),
        ],
      ),
    );
  }

  Container buildMedicationContainer(BuildContext context) {
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
                  'Medication',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 190,
                  child: ListView(
                    children: const [
                      MedicationEntryContainer(
                        isInsulin: true,
                        medicationDailyTherapy: 4,
                        medicationName: 'Novorapid',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildMealContainer(BuildContext context) {
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
                  'Meal - Lunch',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  '122 UH',
                  style: Theme.of(context).textTheme.displaySmall,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 190,
                  child: ListView(
                    children: const [
                      MealEntryContainer(),
                      MealEntryContainer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
