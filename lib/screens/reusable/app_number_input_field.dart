import 'package:diabuddy/extensions/double_extensions.dart';
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class AppNumberInputField extends StatefulWidget {
  const AppNumberInputField({
    Key? key,
    required this.text,
    required this.containerColor,
    required this.controller,
    this.containerBorderRadius,
    this.textInputAction,
    required this.initialValue,
    required this.validator,
  }) : super(key: key);

  final String text;
  final String initialValue;
  final Color containerColor;
  final TextEditingController controller;
  final BorderRadius? containerBorderRadius;
  final TextInputAction? textInputAction;
  final String? Function(String?) validator;

  @override
  State<AppNumberInputField> createState() => _AppNumberInputFieldState();
}

class _AppNumberInputFieldState extends State<AppNumberInputField> {
  late bool isStandardUnit;

  @override
  void initState() {
    super.initState();
    isStandardUnit = UserSimplePreferences.getMeasurementUnit();
    double value = double.parse(widget.controller.text);
    widget.controller.text = value
        .convertIfStandardUnit(
          isStandardUnit,
          value,
        )
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.containerColor,
        borderRadius: widget.containerBorderRadius ?? borderRadius,
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 22,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 22,
                  ),
            ),
            Container(
              width: 76,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 3),
                    color: Colors.grey.shade700,
                    blurRadius: 5,
                  )
                ],
                borderRadius: borderRadius,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.containerColor,
                  borderRadius: borderRadius,
                ),
                child: TextFormField(
                  validator: widget.validator,
                  autofocus: true,
                  textInputAction:
                      widget.textInputAction ?? TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: widget.controller,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: 24,
                            ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    enabledBorder: numberFieldBorder,
                    errorBorder: numberFieldBorder,
                    border: numberFieldBorder,
                    errorMaxLines: 3,
                    contentPadding: const EdgeInsets.only(
                      left: 8,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
