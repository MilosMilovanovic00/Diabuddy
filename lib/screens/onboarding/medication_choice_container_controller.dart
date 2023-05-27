import 'package:diabuddy/screens/reusable/medication_choice_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MedicationChoiceContainerController extends StatefulWidget {
  const MedicationChoiceContainerController({
    Key? key,
    required this.isInsulinChecked,
    required this.arePillsChecked,
    required this.setCheckedAttribute,
  }) : super(key: key);

  final bool isInsulinChecked;
  final bool arePillsChecked;
  final Function(bool) setCheckedAttribute;

  @override
  State<MedicationChoiceContainerController> createState() =>
      _MedicationChoiceContainerControllerState();
}

class _MedicationChoiceContainerControllerState
    extends State<MedicationChoiceContainerController> {
  late bool isInsulinChecked;
  late bool arePillsChecked;

  @override
  void initState() {
    super.initState();
    isInsulinChecked = widget.isInsulinChecked;
    arePillsChecked = widget.arePillsChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MedicationChoiceContainer(
            medicationName: AppLocalizations.of(context)!.insulin,
            medicationIconPath: './assets/svg/syringe_icon.svg',
            isSelected: isInsulinChecked,
            callback: setInsulinChecked,
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Expanded(
          child: MedicationChoiceContainer(
            medicationName: AppLocalizations.of(context)!.pills,
            medicationIconPath: './assets/svg/pills_icon.svg',
            isSelected: arePillsChecked,
            callback: setPillsChecked,
          ),
        ),
      ],
    );
  }

  void setInsulinChecked() {
    setState(() {
      isInsulinChecked = true;
      arePillsChecked = false;
    });
    widget.setCheckedAttribute(isInsulinChecked);
  }

  void setPillsChecked() {
    setState(() {
      isInsulinChecked = false;
      arePillsChecked = true;
    });
    widget.setCheckedAttribute(isInsulinChecked);
  }
}
