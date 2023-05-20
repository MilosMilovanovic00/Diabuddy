import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_input_field.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlucoseTargetOnboardingScreen extends StatefulWidget {
  const GlucoseTargetOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<GlucoseTargetOnboardingScreen> createState() =>
      _GlucoseTargetOnboardingScreenState();
}

class _GlucoseTargetOnboardingScreenState
    extends State<GlucoseTargetOnboardingScreen> {
  late TextEditingController chGlucoseController;
  late TextEditingController amGlucoseController;
  late TextEditingController bmGlucoseController;
  late TextEditingController lGlucoseController;
  late TextEditingController clGlucoseController;

  @override
  void initState() {
    super.initState();
    chGlucoseController = TextEditingController();
    amGlucoseController = TextEditingController();
    bmGlucoseController = TextEditingController();
    lGlucoseController = TextEditingController();
    clGlucoseController = TextEditingController();
  }

  @override
  void dispose() {
    chGlucoseController.dispose();
    amGlucoseController.dispose();
    bmGlucoseController.dispose();
    lGlucoseController.dispose();
    clGlucoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                AppLocalizations.of(context)!
                    .glucoseTargetOnboardingScreenTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!
                    .glucoseTargetOnboardingScreenBodyText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              AppNumberInputField(
                text: AppLocalizations.of(context)!.criticalHigh,
                containerColor: highSugarColor,
                controller: chGlucoseController,
              ),
              const SizedBox(
                height: 20,
              ),
              AppNumberInputField(
                text: AppLocalizations.of(context)!.afterMeal,
                containerColor: goodSugarColor,
                controller: amGlucoseController,
                containerBorderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              AppNumberInputField(
                text: AppLocalizations.of(context)!.beforeMeal,
                containerColor: goodSugarColor,
                controller: bmGlucoseController,
                containerBorderRadius: BorderRadius.zero,
              ),
              AppNumberInputField(
                text: AppLocalizations.of(context)!.low,
                containerColor: goodSugarColor,
                controller: lGlucoseController,
                containerBorderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppNumberInputField(
                text: AppLocalizations.of(context)!.criticalLow,
                containerColor: lowSugarColor,
                controller: clGlucoseController,
                textInputAction: TextInputAction.done,
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
