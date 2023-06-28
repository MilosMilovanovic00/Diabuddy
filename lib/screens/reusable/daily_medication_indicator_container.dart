import 'package:diabuddy/model/dto/medication_dto.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyMedicationIndicatorContainer extends StatelessWidget {
  const DailyMedicationIndicatorContainer({
    Key? key,
    required this.medication,
  }) : super(key: key);

  final MedicationDto medication;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 220,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        gradient: containerColorGradient,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: medication.medicationName,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 22),
                    ),
                    TextSpan(
                      text: '\n${medication.dailyIntake} taken',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 6.0,
                left: 10,
              ),
              child: SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }
}
