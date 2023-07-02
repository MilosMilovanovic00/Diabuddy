import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/small_app_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicationSetupContainer extends StatefulWidget {
  const MedicationSetupContainer({
    Key? key,
    required this.medication,
  }) : super(key: key);

  final Medication medication;

  @override
  State<MedicationSetupContainer> createState() =>
      _MedicationSetupContainerState();
}

class _MedicationSetupContainerState extends State<MedicationSetupContainer> {
  bool selected = false;
  late int medicationTherapyAmount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10.0,
          left: 5,
          right: 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: selected ? primaryColor.withOpacity(0.7) : Colors.white,
            boxShadow: selected ? [] : [simpleBoxShadow],
            border: selected ? Border.all(color: primaryColor, width: 3) : null,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.medication.medicineName,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: selected
                                ? Colors.white
                                : primaryColor.withOpacity(0.7),
                          ),
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        widget.medication.isInsulin
                            ? './assets/svg/syringe_icon.svg'
                            : './assets/svg/pills_icon.svg',
                        colorFilter: ColorFilter.mode(
                            selected
                                ? Colors.white
                                : primaryColor.withOpacity(0.7),
                            BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
              selected ? buildDishExtension(context) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDishExtension(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius.copyWith(
                topLeft: const Radius.circular(0),
                topRight: const Radius.circular(0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppNumberPicker(
                        textColor: primaryColor,
                        minValue: 0,
                        maxValue: 40,
                        setCurrentValue: setMedicationTherapyAmount,
                      ),
                      Text(
                        widget.medication.isInsulin?'units':'pills',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: primaryColor.withOpacity(0.7),
                                ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmallAppButton(
                      callback: () {},
                      text: 'Cancel',
                      textColor: primaryColor,
                      backgroundColor: Colors.white,
                    ),
                    SmallAppButton(callback: () {}, text: 'Save'),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void setMedicationTherapyAmount(int value) {
    setState(() {
      medicationTherapyAmount = value;
    });
  }
}
