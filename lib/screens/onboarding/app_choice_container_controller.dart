import 'package:diabuddy/screens/reusable/app_choice_containter.dart';
import 'package:flutter/material.dart';

class AppChoiceContainerController extends StatefulWidget {
  const AppChoiceContainerController({
    Key? key,
    required this.isSIUnitChecked,
    required this.isNoSIUnitChecked,
  }) : super(key: key);

  final bool isSIUnitChecked;
  final bool isNoSIUnitChecked;

  @override
  State<AppChoiceContainerController> createState() =>
      _AppChoiceContainerControllerState();
}

class _AppChoiceContainerControllerState
    extends State<AppChoiceContainerController> {
  late bool isSIUnitChecked;
  late bool isNoSIUnitChecked;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppChoiceContainer(
          isSelected: isSIUnitChecked,
          callback: setSIUnitChecked,
          text: 'mmol/L',
        ),
        const SizedBox(
          height: 20,
        ),
        AppChoiceContainer(
          isSelected: isNoSIUnitChecked,
          callback: setNoSIUnitChecked,
          text: 'mg/dl',
        ),
      ],
    );
  }

  void setSIUnitChecked() {
    setState(() {
      isSIUnitChecked = true;
      isNoSIUnitChecked = false;
    });
  }

  void setNoSIUnitChecked() {
    setState(() {
      isSIUnitChecked = false;
      isNoSIUnitChecked = true;
    });
  }

  @override
  void initState() {
    super.initState();
    isSIUnitChecked = widget.isSIUnitChecked;
    isNoSIUnitChecked = widget.isNoSIUnitChecked;
  }
}
