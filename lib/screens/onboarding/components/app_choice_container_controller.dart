import 'package:diabuddy/screens/reusable/app_choice_containter.dart';
import 'package:flutter/material.dart';

class AppChoiceContainerController extends StatefulWidget {
  const AppChoiceContainerController({
    Key? key,
    required this.firstChoice,
    required this.secondChoice,
    required this.firstChoiceText,
    required this.secondChoiceText,
  }) : super(key: key);

  final bool firstChoice;
  final bool secondChoice;
  final String firstChoiceText;
  final String secondChoiceText;

  @override
  State<AppChoiceContainerController> createState() =>
      _AppChoiceContainerControllerState();
}

class _AppChoiceContainerControllerState
    extends State<AppChoiceContainerController> {
  late bool firstChoice;
  late bool secondChoice;
  late String firstChoiceText;
  late String secondChoiceText;

  @override
  void initState() {
    super.initState();
    firstChoice = widget.firstChoice;
    secondChoice = widget.secondChoice;
    firstChoiceText = widget.firstChoiceText;
    secondChoiceText = widget.secondChoiceText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppChoiceContainer(
          isSelected: firstChoice,
          callback: setFirstChoiceChecked,
          text: firstChoiceText,
        ),
        const SizedBox(
          height: 20,
        ),
        AppChoiceContainer(
          isSelected: secondChoice,
          callback: setSecondChecked,
          text: secondChoiceText,
        ),
      ],
    );
  }

  void setFirstChoiceChecked() {
    setState(() {
      firstChoice = true;
      secondChoice = false;
    });
  }

  void setSecondChecked() {
    setState(() {
      firstChoice = false;
      secondChoice = true;
    });
  }
}
