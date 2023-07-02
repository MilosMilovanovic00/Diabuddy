import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class AppDropdownContainer extends StatefulWidget {
  const AppDropdownContainer({
    Key? key,
    required this.setChoice,
    required this.choices,
  }) : super(key: key);

  final Function(String) setChoice;
  final List<String> choices;

  @override
  State<AppDropdownContainer> createState() => _AppDropdownContainerState();
}

class _AppDropdownContainerState extends State<AppDropdownContainer> {
  late String defaultChoice;
  late List<String> possibleChoices = [];

  @override
  void initState() {
    super.initState();
    possibleChoices = widget.choices;
    defaultChoice = possibleChoices.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: defaultChoice,
      borderRadius: borderRadius,
      dropdownColor: primaryColor,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      items: possibleChoices
          .map(
            (String item) => DropdownMenuItem(
              value: item,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          defaultChoice = value!;
        });
        widget.setChoice(value!);
      },
    );
  }
}
