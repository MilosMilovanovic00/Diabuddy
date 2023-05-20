import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class AppNumberInputField extends StatelessWidget {
  const AppNumberInputField({
    Key? key,
    required this.text,
    required this.containerColor,
    required this.controller,
    this.containerBorderRadius,
    this.textInputAction,
  }) : super(key: key);

  final String text;
  final Color containerColor;
  final TextEditingController controller;
  final BorderRadius? containerBorderRadius;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: containerBorderRadius ?? borderRadius,
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
              text,
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
                  color: containerColor,
                  borderRadius: borderRadius,
                ),
                child: TextFormField(
                  autofocus: true,
                  textInputAction: textInputAction ?? TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: controller,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.start,
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
                      left: 24,
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
