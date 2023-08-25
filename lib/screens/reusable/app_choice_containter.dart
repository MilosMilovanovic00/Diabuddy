import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class AppChoiceContainer extends StatelessWidget {
  const AppChoiceContainer({
    Key? key,
    required this.isSelected,
    required this.callback,
    required this.text,
  }) : super(key: key);

  final bool isSelected;
  final Function callback;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.7) : Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: borderRadius,
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    blurStyle: BlurStyle.normal,
                    color: Colors.grey.shade600,
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  )
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20,
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isSelected ? Colors.white : primaryColor,
                ),
          ),
        ),
      ),
    );
  }
}
