import 'package:diabuddy/screens/reusable/coloured_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlucoseEntryContainer extends StatelessWidget {
  const GlucoseEntryContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: goodSugarColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 22,
                      ),
                  children: [
                    const TextSpan(text: '5.8 '),
                    const TextSpan(text: 'mmol/L\n'),
                    TextSpan(
                      text: '12:48',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const ColouredIconButton(
                    backgroundColor: goodSugarColor,
                    icon: Icon(
                      Icons.directions_run_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const ColouredIconButton(
                    backgroundColor: goodSugarColor,
                    icon: Icon(
                      Icons.flatware_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ColouredIconButton(
                    backgroundColor: goodSugarColor,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        './assets/svg/medicine.svg',
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  //TODO ovde treba da se doda poslednja ikonica
                  const ColouredIconButton(
                    backgroundColor: goodSugarColor,
                    icon: Icon(
                      Icons.flatware_rounded,
                      color: Colors.white,
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
