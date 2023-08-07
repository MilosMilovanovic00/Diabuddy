import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/screens/onboarding/components/medication_choice_container_controller.dart';
import 'package:diabuddy/screens/onboarding/components/simple_app_container.dart';
import 'package:diabuddy/screens/onboarding/therapy_onboarding_screen.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/app_text_field_input.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  late TextEditingController medicationNameController;
  late bool isInsulinChecked = false;
  late bool arePillsChecked = false;
  late int dailyMedicationIntake;
  late int insulinDose;

  @override
  void initState() {
    super.initState();
    medicationNameController = TextEditingController();
    dailyMedicationIntake = 5;
    insulinDose = 1;
  }

  @override
  void dispose() {
    medicationNameController.dispose();
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
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is SuccessfulMedicationAddition) {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const TherapyOnboardingScreen(),
              ),
            );
          } else if (state is MedicationAdditionFailed) {
            print('nesto nije dobro');
            //TODO something went wrong
          }
        },
        child: SafeArea(
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
                  AppLocalizations.of(context)!.addMedication,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  AppLocalizations.of(context)!.chooseMedicationType,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 20,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 420,
                    child: ListView(
                      children: [
                        MedicationChoiceContainerController(
                          isInsulinChecked: isInsulinChecked,
                          arePillsChecked: arePillsChecked,
                          setCheckedAttribute: (bool value) {
                            setState(() {
                              isInsulinChecked = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildInsulinDosePicker(context),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextFieldInput(
                          hintText:
                              AppLocalizations.of(context)!.medicationName,
                          controller: medicationNameController,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'You cannot leave this field blank';
                            }
                            return null;
                          },
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SimpleAppContainer(
                          text: AppLocalizations.of(context)!
                              .dailyMedicationIntake,
                          fontSize: 18,
                          widget: AppNumberPicker(
                            minValue: 1,
                            maxValue: 100,
                            currentValue: 4,
                            setCurrentValue: setDailyMedicationIntake,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                AppButton(
                  callback: () {
                    saveMedication();
                  },
                  text: AppLocalizations.of(context)!.save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Visibility buildInsulinDosePicker(BuildContext context) {
    return Visibility(
      visible: isInsulinChecked,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          shape: BoxShape.rectangle,
          gradient: containerColorGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppLocalizations.of(context)!.averageInsulinIntake,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              AppNumberPicker(
                widgetHeight: 40,
                widgetWidth: 40,
                axis: Axis.vertical,
                minValue: 1,
                maxValue: 50,
                currentValue: insulinDose,
                setCurrentValue: setInsulinDose,
              ),
              Text(
                AppLocalizations.of(context)!.units,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setDailyMedicationIntake(int value) {
    setState(() {
      dailyMedicationIntake = value;
    });
  }

  void setInsulinDose(int value) {
    setState(() {
      insulinDose = value;
    });
  }

  void saveMedication() {
    AddMedicationEvent addMedicationEvent = AddMedicationEvent(
      medicationName: medicationNameController.text.trim(),
      dailyMedicationIntake: dailyMedicationIntake,
      isInsulin: isInsulinChecked,
      insulinDose: isInsulinChecked ? insulinDose : 0,
    );
    BlocProvider.of<UserBloc>(context).add(addMedicationEvent);
  }
}
