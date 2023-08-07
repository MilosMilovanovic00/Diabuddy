import 'package:diabuddy/model/enitity/therapy.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MedicationEntryContainer extends StatelessWidget {
  const MedicationEntryContainer({
    Key? key,
    required this.therapy,
  }) : super(key: key);

  final Therapy therapy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8,
      ),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade700,
              offset: const Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  therapy.name,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Text(
                    '${therapy.dose} ${therapy.isInsulin ? AppLocalizations.of(context)!.units[0] : AppLocalizations.of(context)!.pills}',
                    style: Theme.of(context).textTheme.displaySmall,
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
