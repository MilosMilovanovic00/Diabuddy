import 'package:diabuddy/screens/reusable/app_choice_containter.dart';
import 'package:flutter/material.dart';

class AppChoiceContainerController extends StatefulWidget {
  const AppChoiceContainerController({
    Key? key,
    required this.isFirstChoice,
    required this.firstChoiceText,
    required this.secondChoiceText,
    required this.setChoice,
  }) : super(key: key);

  final bool isFirstChoice;
  final String firstChoiceText;
  final String secondChoiceText;
  final Function(bool) setChoice;

  @override
  State<AppChoiceContainerController> createState() =>
      _AppChoiceContainerControllerState();
}

class _AppChoiceContainerControllerState
    extends State<AppChoiceContainerController> {
  late bool isFirstChoice;
  late bool isSecondChoice;
  late String firstChoiceText;
  late String secondChoiceText;

  @override
  void initState() {
    super.initState();
    isFirstChoice = widget.isFirstChoice;
    isSecondChoice = !widget.isFirstChoice;
    firstChoiceText = widget.firstChoiceText;
    secondChoiceText = widget.secondChoiceText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppChoiceContainer(
          isSelected: isFirstChoice,
          callback: changeChoices,
          text: firstChoiceText,
        ),
        const SizedBox(
          height: 20,
        ),
        AppChoiceContainer(
          isSelected: isSecondChoice,
          callback: changeChoices,
          text: secondChoiceText,
        ),
      ],
    );
  }

  void changeChoices() {
    setState(() {
      isFirstChoice = !isFirstChoice;
      isSecondChoice = !isSecondChoice;
    });
    widget.setChoice(isFirstChoice);
  }
}
