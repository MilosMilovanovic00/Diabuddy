import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class SmallAppButton extends StatelessWidget {
  const SmallAppButton({
    Key? key,
    this.backgroundColor,
    this.textColor,
    required this.callback,
    required this.text,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? textColor;
  final Function() callback;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: backgroundColor ?? primaryColor,
        borderRadius: borderRadius,
        border: Border.all(color: primaryColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextButton(
          onPressed: callback,
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: textColor ?? Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
