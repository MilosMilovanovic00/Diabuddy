import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicationChoiceContainer extends StatelessWidget {
  const MedicationChoiceContainer({
    Key? key,
    required this.medicationName,
    required this.medicationIconPath,
    required this.isSelected,
    required this.callback,
  }) : super(key: key);

  final String medicationName;
  final bool isSelected;
  final String medicationIconPath;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: borderRadius,
          color: isSelected ? primaryColor.withOpacity(0.7) : Colors.white,
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                      color: Colors.grey.shade700,
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 1),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                medicationName,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: isSelected
                          ? Colors.white
                          : primaryColor.withOpacity(0.7),
                    ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  medicationIconPath,
                  colorFilter: ColorFilter.mode(
                      isSelected ? Colors.white : primaryColor.withOpacity(0.7),
                      BlendMode.srcIn),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
