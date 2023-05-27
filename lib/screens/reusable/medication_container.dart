import 'package:diabuddy/model/dto/Medication.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MedicationContainer extends StatelessWidget {
  const MedicationContainer({
    Key? key,
    required this.medication,
    required this.callback,
  }) : super(key: key);

  final Medication medication;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: containerColorGradient,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    medication.medicationName,
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: borderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: borderRadius,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.dailyIntake}: ${medication.dailyIntake}',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  Text(
                    medication.isInsulin
                        ? '${AppLocalizations.of(context)!.units}: ${medication.insulinUnits}'
                        : '',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      medication.isInsulin
                          ? './assets/svg/syringe_icon.svg'
                          : './assets/svg/pills_icon.svg',
                      colorFilter: const ColorFilter.mode(Colors.white,BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
