import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AppNumberPicker extends StatefulWidget {
  const AppNumberPicker({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.setCurrentValue,
    this.currentValue,
    this.step,
    this.axis,
    this.widgetHeight,
    this.widgetWidth,
    this.textColor,
    this.selectedTextSize,
    this.unselectedTextSize,
  }) : super(key: key);
  final int minValue;
  final int maxValue;
  final int? currentValue;
  final Color? textColor;
  final double? selectedTextSize;
  final double? unselectedTextSize;
  final int? step;
  final Axis? axis;
  final double? widgetHeight;
  final double? widgetWidth;
  final Function setCurrentValue;

  @override
  State<AppNumberPicker> createState() => _AppNumberPickerState();
}

class _AppNumberPickerState extends State<AppNumberPicker> {
  late int currentValue;

  @override
  void initState() {
    currentValue = widget.currentValue ?? 50;
  }

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      minValue: widget.minValue,
      itemHeight: widget.widgetHeight ?? 60,
      itemWidth: widget.widgetWidth ?? 60,
      step: widget.step ?? 1,
      maxValue: widget.maxValue,
      axis: widget.axis ?? Axis.horizontal,
      value: currentValue,
      textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: widget.unselectedTextSize ?? 17,
            color: widget.textColor ?? Colors.white,
          ),
      selectedTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: widget.selectedTextSize ?? 27,
            color: widget.textColor ?? Colors.white,
          ),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
        shape: BoxShape.rectangle,
        color: Colors.white.withOpacity(0.2),
      ),
      onChanged: (int value) {
        setState(() {
          currentValue = value;
        });
        widget.setCurrentValue(value);
      },
    );
  }
}
