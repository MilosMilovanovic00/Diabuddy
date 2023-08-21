import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/screens/onboarding/therapy_notification_screen.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicationContainer extends StatelessWidget {
  const MedicationContainer({
    Key? key,
    required this.medication,
    required this.deleteMedication,
  }) : super(key: key);

  final Medication medication;
  final Function deleteMedication;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: containerColorGradient,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      medication.medicationName,
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  ColouredIconButton(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TherapyNotificationScreen(
                            therapyId: medication.medicationId!,
                            therapyName: medication.medicationName,
                          ),
                        ),
                      );
                    },
                    backgroundColor: primaryColor,
                    icon: const Icon(
                      Icons.notification_add_sharp,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ColouredIconButton(
                    callback: () {
                      deleteMedication(medication.medicationId);
                    },
                    backgroundColor: primaryColor,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.dailyIntake}: ${medication.dailyMedicationIntake}',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  Text(
                    medication.isInsulin
                        ? '${AppLocalizations.of(context)!.units}: ${medication.averageInsulinUnits}'
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
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
