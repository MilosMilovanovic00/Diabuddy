import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/screens/onboarding/components/app_choice_container_controller.dart';
import 'package:diabuddy/screens/onboarding/therapy_onboarding_screen.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnitsOnboardingScreen extends StatefulWidget {
  const UnitsOnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UnitsOnboardingScreen> createState() => _UnitsOnboardingScreenState();
}

class _UnitsOnboardingScreenState extends State<UnitsOnboardingScreen> {
  late bool isStandardUnit;

  @override
  void initState() {
    super.initState();
    isStandardUnit = UserSimplePreferences.isStandardMeasurementUnit() ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                AppLocalizations.of(context)!.unitsOnboardingTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.unitsOnboardingBodyText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              AppChoiceContainerController(
                isFirstChoice: isStandardUnit,
                firstChoiceText: 'mmol/L',
                secondChoiceText: 'mg/dl',
                setChoice: setStandardUnit,
              ),
              const Spacer(),
              AppButton(
                callback: () {
                  UserSimplePreferences.setMeasurementUnit(isStandardUnit);
                  //TODO ovo mora da se izmeni da ide pop up ili sledeca
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TherapyOnboardingScreen(),
                    ),
                  );
                },
                text: AppLocalizations.of(context)!.save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setStandardUnit(bool value) {
    setState(() {
      isStandardUnit = value;
    });
  }
}
