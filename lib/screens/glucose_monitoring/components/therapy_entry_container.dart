import 'package:diabuddy/model/enitity/therapy.dart';
import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TherapyEntryContainer extends StatelessWidget {
  const TherapyEntryContainer({
    super.key,
    required this.therapy,
    required this.deleteTherapy,
  });

  final Therapy therapy;
  final Function() deleteTherapy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: containerColorGradient,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      therapy.name,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      therapy.isInsulin
                          ? AppLocalizations.of(context)!
                              .doseOfMedicineIsInsulin(therapy.dose)
                          : AppLocalizations.of(context)!
                              .doseOfMedicineArePills(therapy.dose),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColouredIconButton(
                    callback: deleteTherapy,
                    backgroundColor: primaryColor,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      therapy.isInsulin
                          ? './assets/svg/syringe_icon.svg'
                          : './assets/svg/pills_icon.svg',
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
