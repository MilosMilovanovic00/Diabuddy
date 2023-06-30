import 'package:diabuddy/screens/onboarding/medication_choice_container_controller.dart';
import 'package:diabuddy/screens/onboarding/simple_app_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/app_text_field_input.dart';
import 'package:diabuddy/screens/reusable/insulin_type_picker.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
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
  late int medicationUnits;
  late String insulinType;

  @override
  void initState() {
    super.initState();
    medicationNameController = TextEditingController();
    dailyMedicationIntake = 4;
    medicationUnits = 4;
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
                        hintText: AppLocalizations.of(context)!.medicationName,
                        controller: medicationNameController,
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'You must enter medication name!';
                          } else {
                            return value;
                          }
                        },
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SimpleAppContainer(
                        text:
                            AppLocalizations.of(context)!.dailyMedicationIntake,
                        fontSize: 18,
                        widget: AppNumberPicker(
                          minValue: 1,
                          maxValue: 100,
                          currentValue: 4,
                          setCurrentValue: setDailyMedicationIntake,
                        ),
                      ),
                    ],
                  ),
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
              InsulinTypePicker(
                setInsulinType: setInsulinType,
                choices: [
                  AppLocalizations.of(context)!.fastLastingInsulin,
                  AppLocalizations.of(context)!.longLastingInsulin,
                ],
              ),
              AppNumberPicker(
                widgetHeight: 40,
                widgetWidth: 40,
                axis: Axis.vertical,
                minValue: 1,
                maxValue: 20,
                currentValue: medicationUnits,
                setCurrentValue: setMedicationUnits,
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

  void setMedicationUnits(int value) {
    setState(() {
      medicationUnits = value;
    });
  }

  void setInsulinType(String value) {
    setState(() {
      insulinType = value;
    });
  }
}
