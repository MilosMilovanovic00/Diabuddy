import 'package:diabuddy/model/dto/Medication.dart';
import 'package:diabuddy/screens/onboarding/add_medication_screen.dart';
import 'package:diabuddy/screens/reusable/app_add_button.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/medication_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TherapyOnboardingScreen extends StatefulWidget {
  const TherapyOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<TherapyOnboardingScreen> createState() =>
      _TherapyOnboardingScreenState();
}

class _TherapyOnboardingScreenState extends State<TherapyOnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Medication> list = [
      Medication(
          dailyIntake: 4,
          insulinUnits: 6,
          isInsulin: true,
          medicationName: 'NovoRapid'),
      Medication(
          dailyIntake: 4,
          insulinUnits: 6,
          isInsulin: true,
          medicationName: 'NovoRapid'),
      Medication(
          dailyIntake: 4,
          insulinUnits: 6,
          isInsulin: true,
          medicationName: 'NovoRapid'),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.therapyOnboardingTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.therapyOnboardingBodyText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              AppAddButton(
                text: AppLocalizations.of(context)!.addMedication,
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMedicationScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 350,
                  child: ListView(
                      children: list
                          .map((medication) => MedicationContainer(
                                medication: medication,
                                callback: () {},
                              ))
                          .toList()),
                ),
              ),
              const Spacer(),
              AppButton(
                callback: () {},
                text: AppLocalizations.of(context)!.save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
