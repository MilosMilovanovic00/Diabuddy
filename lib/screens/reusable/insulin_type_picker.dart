import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class InsulinTypePicker extends StatefulWidget {
  const InsulinTypePicker({
    Key? key,
    required this.setInsulinType,
    required this.choices,
  }) : super(key: key);

  final Function(String) setInsulinType;
  final List<String> choices;

  @override
  State<InsulinTypePicker> createState() => _InsulinTypePickerState();
}

class _InsulinTypePickerState extends State<InsulinTypePicker> {
  late String chosenInsulinType;
  late List<String> insulinTypes = [];

  @override
  void initState() {
    super.initState();
    insulinTypes=widget.choices;
    chosenInsulinType = insulinTypes.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: chosenInsulinType,
      borderRadius: borderRadius,
      dropdownColor: primaryColor,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      items: insulinTypes
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
          chosenInsulinType = value!;
        });
        widget.setInsulinType(value!);
      },
    );
  }
}
