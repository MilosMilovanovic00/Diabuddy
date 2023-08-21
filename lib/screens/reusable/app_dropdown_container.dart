import 'package:diabuddy/model/enitity/enum/activity_type.dart';
import 'package:diabuddy/model/enitity/enum/meal_type.dart';
import 'package:diabuddy/model/enitity/enum/notification_type.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class AppDropdownContainer extends StatefulWidget {
  const AppDropdownContainer({
    Key? key,
    required this.setChoice,
    required this.choices,
    required this.choice,
  }) : super(key: key);

  final Function(dynamic) setChoice;
  final List<dynamic> choices;
  final dynamic choice;

  @override
  State<AppDropdownContainer> createState() => _AppDropdownContainerState();
}

class _AppDropdownContainerState extends State<AppDropdownContainer> {
  late dynamic choice;
  late List<dynamic> possibleChoices = [];

  @override
  void initState() {
    super.initState();
    possibleChoices = widget.choices;
    choice = widget.choice;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
      value: choice,
      borderRadius: borderRadius,
      dropdownColor: primaryColor,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      items: possibleChoices
          .map(
            (dynamic item) => DropdownMenuItem(
              value: item,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  getText(item),
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (dynamic value) {
        setState(() {
          choice = value!;
        });
        widget.setChoice(value!);
      },
    );
  }

  String getText(dynamic choice) {
    if (choice is MealType) {
      return getMealType(choice, context);
    } else if (choice is ActivityIntensity) {
      return getStringForActivityIntensity(choice, context);
    } else if (choice is NotificationType) {
      return getNotificationType(choice, context);
    } else {
      return "";
    }
  }
}
